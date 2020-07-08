From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 8 Jul 2020 22:55:21 +0000
Subject: [Intel-wired-lan] [net-next,
 v7 5/5] ice: add switch rule management for DCF
In-Reply-To: <20200701012557.40234-6-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200701012557.40234-1-haiyue.wang@intel.com>
 <20200701012557.40234-6-haiyue.wang@intel.com>
Message-ID: <eca3253391dd34a267e607dbd847d6878bc3a6fe.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-07-01 at 09:25 +0800, Haiyue Wang wrote:
> The PF shall track all the outstanding switch filters (filter IDs to
> be
> precise) added by the DCF.
> 
> Upon a VF reset event, the PF shall clear all outstanding switch
> filters
> for the given VF. Upon completion of either VF or PF reset, the PF
> shall
> skip replay of filters that were added by the DCF. The PF shall
> however
> continue to replay the filters that were not added by DCF for the
> VF(s).
> 
> If the trust mode of the DCF is taken away without the DCF gracefully
> relinquishing the DCF functionality (by way appropriate virtchnl
> message
> exchanges), then the PF shall remove all switch filters that were
> added
> by the DCF. The PF shall transition back from DCF mode to regular
> mode,
> the VF shall be treated as any other untrusted VF, and the PF will
> reset
> the VF.
> 
> If a designated DCF requests AVF functionality from the same VF (VF-
> ID)
> without the DCF gracefully relinquishing the DCF functionality first
> (by
> way appropriate virtchnl message exchanges), the PF shall remove all
> the
> switch filters that were added by the DCF.
> 
> Signed-off-by: Xiao Zhang <xiao.zhang@intel.com>
> Signed-off-by: Beilei Xing <beilei.xing@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcf.c      | 713
> ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcf.h      |  41 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  16 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  27 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   9 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  40 +
>  6 files changed, 821 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dcf.c
> b/drivers/net/ethernet/intel/ice/ice_dcf.c
> index e7d37735aaa5..154005f1b634 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcf.c
> @@ -124,3 +124,716 @@ void ice_dcf_set_state(struct ice_pf *pf, enum
> ice_dcf_state state)
>  
>  	pf->dcf.state = state;
>  }
> +
> +/**
> + * ice_dcf_rm_sw_rule_to_vsi - remove switch rule of "forward to
> VSI"
> + * @pf: pointer to the PF struct
> + * @s_entry: pointer to switch rule entry to remove
> + */
> +static int
> +ice_dcf_rm_sw_rule_to_vsi(struct ice_pf *pf,
> +			  struct ice_dcf_sw_rule_entry *s_entry)
> +{
> +	struct ice_aqc_sw_rules_elem *s_rule;
> +	enum ice_status status;
> +
> +	s_rule = kzalloc(ICE_SW_RULE_RX_TX_NO_HDR_SIZE, GFP_KERNEL);
> +	if (!s_rule)
> +		return -ENOMEM;
> +
> +	s_rule->type = cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
> +	s_rule->pdata.lkup_tx_rx.act = 0;
> +	s_rule->pdata.lkup_tx_rx.hdr_len = 0;
> +	s_rule->pdata.lkup_tx_rx.index = cpu_to_le16(s_entry->rule_id);
> +	status = ice_aq_sw_rules(&pf->hw, s_rule,
> ICE_SW_RULE_RX_TX_NO_HDR_SIZE,
> +				 1, ice_aqc_opc_remove_sw_rules, NULL);
> +	kfree(s_rule);
> +	if (status)
> +		return -EIO;
> +
> +	list_del(&s_entry->list_entry);
> +	kfree(s_entry);
> +	return 0;
> +}
> +
> +/**
> + * ice_dcf_rm_sw_rule_to_vsi_list - remove switch rule of "forward
> to VSI list"
> + * @pf: pointer to the PF struct
> + * @s_entry: pointer to switch rule entry to remove
> + */
> +static int
> +ice_dcf_rm_sw_rule_to_vsi_list(struct ice_pf *pf,
> +			       struct ice_dcf_sw_rule_entry *s_entry)
> +{
> +	struct ice_dcf_vsi_list_info *vsi_list_info = s_entry-
> >vsi_list_info;
> +	struct ice_aqc_alloc_free_res_elem *res_buf;
> +	struct ice_aqc_sw_rules_elem *s_rule;
> +	enum ice_status status;
> +	u16 rule_sz;
> +	u16 vsi_id;
> +	int i = 0;
> +
> +	if (!vsi_list_info)
> +		return -EINVAL;
> +
> +	/* The VSI list is empty, it can be freed immediately */
> +	if (!vsi_list_info->vsi_count)
> +		goto free_vsi_list;
> +
> +	rule_sz = ICE_SW_RULE_VSI_LIST_SIZE(vsi_list_info->vsi_count);
> +	s_rule = kzalloc(rule_sz, GFP_KERNEL);
> +	if (!s_rule)
> +		return -ENOMEM;
> +
> +	s_rule->type = cpu_to_le16(ICE_AQC_SW_RULES_T_VSI_LIST_CLEAR);
> +	s_rule->pdata.vsi_list.index = cpu_to_le16(vsi_list_info-
> >list_id);
> +	s_rule->pdata.vsi_list.number_vsi =
> +					cpu_to_le16(vsi_list_info-
> >vsi_count);
> +	for_each_set_bit(vsi_id, vsi_list_info->hw_vsi_map,
> ICE_HW_VSI_ID_MAX)
> +		s_rule->pdata.vsi_list.vsi[i++] = cpu_to_le16(vsi_id);
> +
> +	bitmap_zero(vsi_list_info->hw_vsi_map, ICE_HW_VSI_ID_MAX);
> +	vsi_list_info->vsi_count = 0;
> +
> +	status = ice_aq_sw_rules(&pf->hw, s_rule, rule_sz, 1,
> +				 ice_aqc_opc_update_sw_rules, NULL);
> +	kfree(s_rule);
> +	if (status)
> +		return -EIO;
> +
> +free_vsi_list:
> +	res_buf = kzalloc(sizeof(*res_buf), GFP_KERNEL);
> +	if (!res_buf)
> +		return -ENOMEM;
> +
> +	res_buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_VSI_LIST_REP);
> +	res_buf->num_elems = cpu_to_le16(1);
> +	res_buf->elem[0].e.sw_resp = cpu_to_le16(vsi_list_info-
> >list_id);
> +	status = ice_aq_alloc_free_res(&pf->hw, 1, res_buf,
> sizeof(*res_buf),
> +				       ice_aqc_opc_free_res, NULL);
> +	kfree(res_buf);
> +	if (status)
> +		return -EIO;
> +
> +	list_del(&vsi_list_info->list_entry);
> +	kfree(vsi_list_info);
> +	s_entry->vsi_list_info = NULL;
> +
> +	return ice_dcf_rm_sw_rule_to_vsi(pf, s_entry);
> +}
> +
> +/**
> + * ice_dcf_rm_vsi_from_list - remove VSI from switch rule forward
> VSI list
> + * @pf: pointer to the PF struct
> + * @vsi_list_info: pointer to the VSI list info
> + * @hw_vsi_id: the Hardware VSI number
> + */
> +static int
> +ice_dcf_rm_vsi_from_list(struct ice_pf *pf,
> +			 struct ice_dcf_vsi_list_info *vsi_list_info,
> +			 u16 hw_vsi_id)
> +{
> +	struct ice_aqc_sw_rules_elem *s_rule;
> +	enum ice_status status;
> +
> +	if (!vsi_list_info || !vsi_list_info->vsi_count ||
> +	    !test_bit(hw_vsi_id, vsi_list_info->hw_vsi_map))
> +		return -ENOENT;
> +
> +	s_rule = kzalloc(ICE_SW_RULE_VSI_LIST_SIZE(1), GFP_KERNEL);
> +	if (!s_rule)
> +		return -ENOMEM;
> +
> +	s_rule->type = cpu_to_le16(ICE_AQC_SW_RULES_T_VSI_LIST_CLEAR);
> +	s_rule->pdata.vsi_list.index = cpu_to_le16(vsi_list_info-
> >list_id);
> +	s_rule->pdata.vsi_list.number_vsi = cpu_to_le16(1);
> +	s_rule->pdata.vsi_list.vsi[0] = cpu_to_le16(hw_vsi_id);
> +	status = ice_aq_sw_rules(&pf->hw, s_rule,
> +				 ICE_SW_RULE_VSI_LIST_SIZE(1), 1,
> +				 ice_aqc_opc_update_sw_rules, NULL);
> +	kfree(s_rule);
> +	if (status)
> +		return -EIO;
> +
> +	/* When the VF resets gracefully, it should keep the VSI list
> and its
> +	 * rule, just clears the VSI from list, so that the DCF can
> replay the
> +	 * rule by updating this VF to list successfully.
> +	 */
> +	vsi_list_info->vsi_count--;
> +	clear_bit(hw_vsi_id, vsi_list_info->hw_vsi_map);
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_rm_dcf_sw_vsi_rule - remove switch rules added by DCF to VSI
> + * @pf: pointer to the PF struct
> + * @hw_vsi_id: hardware VSI ID of the VF
> + */
> +void ice_rm_dcf_sw_vsi_rule(struct ice_pf *pf, u16 hw_vsi_id)
> +{
> +	struct ice_dcf_sw_rule_entry *s_entry, *tmp;
> +	int ret;
> +
> +	list_for_each_entry_safe(s_entry, tmp, &pf->dcf.sw_rule_head,
> +				 list_entry)
> +		if (s_entry->fltr_act == ICE_FWD_TO_VSI_LIST) {
> +			ret = ice_dcf_rm_vsi_from_list(pf,
> +						       s_entry-
> >vsi_list_info,
> +						       hw_vsi_id);
> +			if (ret && ret != -ENOENT)
> +				dev_err(ice_pf_to_dev(pf),
> +					"Failed to remove VSI %u from
> VSI list : %d\n",
> +					hw_vsi_id, ret);
> +		} else if (s_entry->fwd_id.hw_vsi_id == hw_vsi_id) {
> +			ret = ice_dcf_rm_sw_rule_to_vsi(pf, s_entry);
> +			if (ret)
> +				dev_err(ice_pf_to_dev(pf),
> +					"Failed to remove VSI %u switch
> rule : %d\n",
> +					hw_vsi_id, ret);
> +		}
> +}
> +
> +/**
> + * ice_dcf_init_sw_rule_mgmt - initializes DCF rule filter mngt
> struct
> + * @pf: pointer to the PF struct
> + */
> +void ice_dcf_init_sw_rule_mgmt(struct ice_pf *pf)
> +{
> +	INIT_LIST_HEAD(&pf->dcf.sw_rule_head);
> +	INIT_LIST_HEAD(&pf->dcf.vsi_list_info_head);
> +}
> +
> +/**
> + * ice_rm_all_dcf_sw_rules - remove switch rules configured by DCF
> + * @pf: pointer to the PF struct
> + */
> +void ice_rm_all_dcf_sw_rules(struct ice_pf *pf)
> +{
> +	struct ice_dcf_vsi_list_info *vsi_list_info, *list_info_tmp;
> +	struct ice_dcf_sw_rule_entry *sw_rule, *rule_tmp;
> +	u16 rule_id, list_id;
> +	int ret;
> +
> +	list_for_each_entry_safe(sw_rule, rule_tmp, &pf-
> >dcf.sw_rule_head,
> +				 list_entry)
> +		if (sw_rule->fltr_act == ICE_FWD_TO_VSI_LIST) {
> +			list_id = sw_rule->fwd_id.vsi_list_id;
> +			rule_id = sw_rule->rule_id;
> +			ret = ice_dcf_rm_sw_rule_to_vsi_list(pf,
> sw_rule);
> +			if (ret)
> +				dev_err(ice_pf_to_dev(pf),
> +					"Failed to remove switch rule
> 0x%04x with list id %u : %d\n",
> +					rule_id, list_id, ret);
> +		} else {
> +			rule_id = sw_rule->rule_id;
> +			ret = ice_dcf_rm_sw_rule_to_vsi(pf, sw_rule);
> +			if (ret)
> +				dev_err(ice_pf_to_dev(pf),
> +					"Failed to remove switch rule
> 0x%04x : %d\n",
> +					rule_id, ret);
> +		}
> +
> +	/* clears rule filter management data if AdminQ command has
> error */
> +	list_for_each_entry_safe(vsi_list_info, list_info_tmp,
> +				 &pf->dcf.vsi_list_info_head,
> +				 list_entry) {
> +		list_del(&vsi_list_info->list_entry);
> +		kfree(vsi_list_info);
> +	}
> +
> +	list_for_each_entry_safe(sw_rule, rule_tmp, &pf-
> >dcf.sw_rule_head,
> +				 list_entry) {
> +		list_del(&sw_rule->list_entry);
> +		kfree(sw_rule);
> +	}
> +}
> +
> +/**
> + * ice_dcf_find_vsi_list_info - find the VSI list by ID.
> + * @pf: pointer to the PF info
> + * @vsi_list_id: VSI list ID
> + */
> +static struct ice_dcf_vsi_list_info *
> +ice_dcf_find_vsi_list_info(struct ice_pf *pf, u16 vsi_list_id)
> +{
> +	struct ice_dcf_vsi_list_info *list_info;
> +
> +	list_for_each_entry(list_info, &pf->dcf.vsi_list_info_head,
> list_entry)
> +		if (list_info->list_id == vsi_list_id)
> +			return list_info;
> +
> +	return NULL;
> +}
> +
> +/**
> + * ice_dcf_add_vsi_id - add new VSI ID into list.
> + * @vsi_list_info: pointer to the VSI list info
> + * @hw_vsi_id: the VSI ID
> + */
> +static void
> +ice_dcf_add_vsi_id(struct ice_dcf_vsi_list_info *vsi_list_info, u16
> hw_vsi_id)
> +{
> +	if (!test_and_set_bit(hw_vsi_id, vsi_list_info->hw_vsi_map))
> +		vsi_list_info->vsi_count++;
> +}
> +
> +/**
> + * ice_dcf_del_vsi_id - delete the VSI ID from list.
> + * @vsi_list_info: pointer to the VSI list info
> + * @hw_vsi_id: the VSI ID
> + */
> +static void
> +ice_dcf_del_vsi_id(struct ice_dcf_vsi_list_info *vsi_list_info, u16
> hw_vsi_id)
> +{
> +	if (test_and_clear_bit(hw_vsi_id, vsi_list_info->hw_vsi_map))
> +		vsi_list_info->vsi_count--;
> +}
> +
> +/**
> + * ice_dcf_parse_alloc_vsi_list_res - parse the allocate VSI list
> resource
> + * @pf: pointer to the PF info
> + * @res: pointer to the VSI list resource
> + */
> +static enum virtchnl_status_code
> +ice_dcf_parse_alloc_vsi_list_res(struct ice_pf *pf,
> +				 struct ice_aqc_res_elem *res)
> +{
> +	struct ice_dcf_vsi_list_info *vsi_list_info;
> +	u16 list_id = le16_to_cpu(res->e.sw_resp);
> +
> +	vsi_list_info = ice_dcf_find_vsi_list_info(pf, list_id);
> +	if (vsi_list_info)
> +		return VIRTCHNL_STATUS_SUCCESS;
> +
> +	vsi_list_info = kzalloc(sizeof(*vsi_list_info), GFP_KERNEL);
> +	if (!vsi_list_info)
> +		return VIRTCHNL_STATUS_ERR_NO_MEMORY;
> +
> +	vsi_list_info->list_id = list_id;
> +	list_add(&vsi_list_info->list_entry, &pf-
> >dcf.vsi_list_info_head);
> +
> +	return VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +/**
> + * ice_dcf_parse_free_vsi_list_res - parse the free VSI list
> resource
> + * @pf: pointer to the PF info
> + * @res: pointer to the VSI list resource
> + */
> +static enum virtchnl_status_code
> +ice_dcf_parse_free_vsi_list_res(struct ice_pf *pf,
> +				struct ice_aqc_res_elem *res)
> +{
> +	struct ice_dcf_vsi_list_info *vsi_list_info;
> +	u16 list_id = le16_to_cpu(res->e.sw_resp);
> +
> +	vsi_list_info = ice_dcf_find_vsi_list_info(pf, list_id);
> +	if (!vsi_list_info)
> +		return VIRTCHNL_STATUS_ERR_PARAM;
> +
> +	if (vsi_list_info->vsi_count)
> +		dev_warn(ice_pf_to_dev(pf),
> +			 "VSI list %u still has %u VSIs to be
> removed!\n",
> +			 list_id, vsi_list_info->vsi_count);
> +
> +	if (vsi_list_info->sw_rule)
> +		vsi_list_info->sw_rule->vsi_list_info = NULL;
> +
> +	list_del(&vsi_list_info->list_entry);
> +	kfree(vsi_list_info);
> +
> +	return VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +/**
> + * ice_dcf_set_vsi_list - set the VSI to VSI list
> + * @pf: pointer to the PF info
> + * @vsi_list: pointer to the VSI ID list to be set
> + */
> +static enum virtchnl_status_code
> +ice_dcf_set_vsi_list(struct ice_pf *pf, struct ice_sw_rule_vsi_list
> *vsi_list)
> +{
> +	struct ice_dcf_vsi_list_info *vsi_list_info;
> +	int i;
> +
> +	vsi_list_info =
> +		ice_dcf_find_vsi_list_info(pf, le16_to_cpu(vsi_list-
> >index));
> +	if (!vsi_list_info)
> +		return VIRTCHNL_STATUS_ERR_PARAM;
> +
> +	for (i = 0; i < le16_to_cpu(vsi_list->number_vsi); i++)
> +		ice_dcf_add_vsi_id(vsi_list_info,
> +				   le16_to_cpu(vsi_list->vsi[i]));
> +
> +	return VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +/**
> + * ice_dcf_clear_vsi_list - clear the VSI from VSI list
> + * @pf: pointer to the PF info
> + * @vsi_list: pointer to the VSI ID list to be cleared
> + */
> +static enum virtchnl_status_code
> +ice_dcf_clear_vsi_list(struct ice_pf *pf, struct
> ice_sw_rule_vsi_list *vsi_list)
> +{
> +	struct ice_dcf_vsi_list_info *vsi_list_info;
> +	int i;
> +
> +	vsi_list_info =
> +		ice_dcf_find_vsi_list_info(pf, le16_to_cpu(vsi_list-
> >index));
> +	if (!vsi_list_info)
> +		return VIRTCHNL_STATUS_ERR_PARAM;
> +
> +	for (i = 0; i < le16_to_cpu(vsi_list->number_vsi); i++)
> +		ice_dcf_del_vsi_id(vsi_list_info,
> +				   le16_to_cpu(vsi_list->vsi[i]));
> +
> +	return VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +/**
> + * ice_dcf_find_sw_rule - find the switch rule by ID.
> + * @pf: pointer to the PF info
> + * @rule_id: switch rule ID
> + */
> +static struct ice_dcf_sw_rule_entry *
> +ice_dcf_find_sw_rule(struct ice_pf *pf, u16 rule_id)
> +{
> +	struct ice_dcf_sw_rule_entry *sw_rule;
> +
> +	list_for_each_entry(sw_rule, &pf->dcf.sw_rule_head, list_entry)
> +		if (sw_rule->rule_id == rule_id)
> +			return sw_rule;
> +
> +	return NULL;
> +}
> +
> +/**
> + * ice_dcf_parse_add_sw_rule_data - parse the add switch rule data
> + * @pf: pointer to the PF info
> + * @lkup: pointer to the add switch rule data
> + */
> +static enum virtchnl_status_code
> +ice_dcf_parse_add_sw_rule_data(struct ice_pf *pf,
> +			       struct ice_sw_rule_lkup_rx_tx *lkup)
> +{
> +	struct ice_dcf_sw_rule_entry *sw_rule;
> +	u32 act;
> +
> +	sw_rule = kzalloc(sizeof(*sw_rule), GFP_KERNEL);
> +	if (!sw_rule)
> +		return VIRTCHNL_STATUS_ERR_NO_MEMORY;
> +
> +	act = le32_to_cpu(lkup->act);
> +	sw_rule->fltr_act = ICE_FWD_TO_VSI;
> +	sw_rule->fwd_id.hw_vsi_id = (act & ICE_SINGLE_ACT_VSI_ID_M) >>
> +					ICE_SINGLE_ACT_VSI_ID_S;
> +	sw_rule->rule_id = le16_to_cpu(lkup->index);
> +
> +	list_add(&sw_rule->list_entry, &pf->dcf.sw_rule_head);
> +
> +	return VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +/**
> + * ice_dcf_parse_updt_sw_rule_data - parse the update switch rule
> data
> + * @pf: pointer to the PF info
> + * @lkup: pointer to the update switch rule data
> + */
> +static enum virtchnl_status_code
> +ice_dcf_parse_updt_sw_rule_data(struct ice_pf *pf,
> +				struct ice_sw_rule_lkup_rx_tx *lkup)
> +{
> +	struct ice_dcf_vsi_list_info *vsi_list_info;
> +	struct ice_dcf_sw_rule_entry *sw_rule;
> +	u16 vsi_list_id, rule_id;
> +	u32 act;
> +
> +	rule_id = le16_to_cpu(lkup->index);
> +	sw_rule = ice_dcf_find_sw_rule(pf, rule_id);
> +	if (!sw_rule)
> +		return VIRTCHNL_STATUS_ERR_PARAM;
> +
> +	act = le32_to_cpu(lkup->act);
> +	if (!(act & ICE_SINGLE_ACT_VSI_LIST)) {
> +		u16 vsi_hw_id = (act & ICE_SINGLE_ACT_VSI_ID_M) >>
> +				ICE_SINGLE_ACT_VSI_ID_S;
> +
> +		sw_rule->fltr_act = ICE_FWD_TO_VSI;
> +		sw_rule->fwd_id.hw_vsi_id = vsi_hw_id;
> +
> +		return VIRTCHNL_STATUS_SUCCESS;
> +	}
> +
> +	vsi_list_id = (act & ICE_SINGLE_ACT_VSI_LIST_ID_M) >>
> +				ICE_SINGLE_ACT_VSI_LIST_ID_S;
> +	if (sw_rule->vsi_list_info) {
> +		if (sw_rule->vsi_list_info->list_id == vsi_list_id)
> +			return VIRTCHNL_STATUS_SUCCESS;
> +
> +		dev_err(ice_pf_to_dev(pf),
> +			"The switch rule 0x%04x is running on VSI list
> %u\n",
> +			rule_id, sw_rule->vsi_list_info->list_id);
> +		return VIRTCHNL_STATUS_ERR_PARAM;
> +	}
> +
> +	vsi_list_info = ice_dcf_find_vsi_list_info(pf, vsi_list_id);
> +	if (!vsi_list_info) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"No VSI list %u found to bind the switch rule
> 0x%04x\n",
> +			vsi_list_id, rule_id);
> +		return VIRTCHNL_STATUS_ERR_PARAM;
> +	}
> +
> +	if (vsi_list_info->sw_rule) {
> +		if (vsi_list_info->sw_rule->rule_id == rule_id)
> +			return VIRTCHNL_STATUS_SUCCESS;
> +
> +		dev_err(ice_pf_to_dev(pf),
> +			"The VSI list %u is running on switch rule
> 0x%04x\n",
> +			vsi_list_id, vsi_list_info->sw_rule->rule_id);
> +		return VIRTCHNL_STATUS_ERR_PARAM;
> +	}
> +
> +	vsi_list_info->sw_rule = sw_rule;
> +
> +	sw_rule->fltr_act = ICE_FWD_TO_VSI_LIST;
> +	sw_rule->fwd_id.vsi_list_id = vsi_list_id;
> +	sw_rule->vsi_list_info = vsi_list_info;
> +
> +	return VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +/**
> + * ice_dcf_parse_rm_sw_rule_data - parse the remove switch rule data
> + * @pf: pointer to the PF info
> + * @lkup: pointer to the remove switch rule data
> + */
> +static enum virtchnl_status_code
> +ice_dcf_parse_rm_sw_rule_data(struct ice_pf *pf,
> +			      struct ice_sw_rule_lkup_rx_tx *lkup)
> +{
> +	struct ice_dcf_sw_rule_entry *sw_rule, *tmp;
> +	u16 rule_id = le16_to_cpu(lkup->index);
> +
> +	list_for_each_entry_safe(sw_rule, tmp, &pf->dcf.sw_rule_head,
> +				 list_entry)
> +		if (sw_rule->rule_id == rule_id) {
> +			list_del(&sw_rule->list_entry);
> +			kfree(sw_rule);
> +		}
> +
> +	return VIRTCHNL_STATUS_SUCCESS;
> +}
> +
> +/**
> + * ice_dcf_handle_add_sw_rule_rsp - handle the add switch rule
> response
> + * @pf: pointer to the PF info
> + * @aq_buf: pointer to the add switch rule command buffer
> + */
> +static enum virtchnl_status_code
> +ice_dcf_handle_add_sw_rule_rsp(struct ice_pf *pf, u8 *aq_buf)
> +{
> +	enum virtchnl_status_code status = VIRTCHNL_STATUS_SUCCESS;
> +	struct ice_aqc_sw_rules_elem *em =
> +			(struct ice_aqc_sw_rules_elem *)aq_buf;
> +	u16 type = le16_to_cpu(em->type);
> +
> +	if (type == ICE_AQC_SW_RULES_T_VSI_LIST_SET)
> +		status = ice_dcf_set_vsi_list(pf, &em->pdata.vsi_list);
> +	else if (type == ICE_AQC_SW_RULES_T_LKUP_RX)
> +		status = ice_dcf_parse_add_sw_rule_data(pf,
> +							&em-
> >pdata.lkup_tx_rx);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_dcf_handle_updt_sw_rule_rsp - handle the update switch rule
> response
> + * @pf: pointer to the PF info
> + * @aq_buf: pointer to the update switch rule command buffer
> + */
> +static enum virtchnl_status_code
> +ice_dcf_handle_updt_sw_rule_rsp(struct ice_pf *pf, u8 *aq_buf)
> +{
> +	enum virtchnl_status_code status = VIRTCHNL_STATUS_SUCCESS;
> +	struct ice_aqc_sw_rules_elem *em =
> +			(struct ice_aqc_sw_rules_elem *)aq_buf;
> +	u16 type = le16_to_cpu(em->type);
> +
> +	if (type == ICE_AQC_SW_RULES_T_VSI_LIST_SET)
> +		status = ice_dcf_set_vsi_list(pf, &em->pdata.vsi_list);
> +	else if (type == ICE_AQC_SW_RULES_T_VSI_LIST_CLEAR)
> +		status = ice_dcf_clear_vsi_list(pf, &em-
> >pdata.vsi_list);
> +	else if (type == ICE_AQC_SW_RULES_T_LKUP_RX)
> +		status = ice_dcf_parse_updt_sw_rule_data(pf,
> +							 &em-
> >pdata.lkup_tx_rx);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_dcf_handle_rm_sw_rule_rsp - handle the remove switch rule
> response
> + * @pf: pointer to the PF info
> + * @aq_buf: pointer to the remove switch rule command buffer
> + */
> +static enum virtchnl_status_code
> +ice_dcf_handle_rm_sw_rule_rsp(struct ice_pf *pf, u8 *aq_buf)
> +{
> +	enum virtchnl_status_code status = VIRTCHNL_STATUS_SUCCESS;
> +	struct ice_aqc_sw_rules_elem *em =
> +			(struct ice_aqc_sw_rules_elem *)aq_buf;
> +	u16 type = le16_to_cpu(em->type);
> +
> +	if (type == ICE_AQC_SW_RULES_T_LKUP_RX)
> +		status = ice_dcf_parse_rm_sw_rule_data(pf,
> +						       &em-
> >pdata.lkup_tx_rx);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_dcf_handle_alloc_res_rsp - handle the allocate resource
> response
> + * @pf: pointer to the PF info
> + * @aq_buf: pointer to the allocate resource command buffer
> + */
> +static enum virtchnl_status_code
> +ice_dcf_handle_alloc_res_rsp(struct ice_pf *pf, u8 *aq_buf)
> +{
> +	enum virtchnl_status_code status = VIRTCHNL_STATUS_SUCCESS;
> +	struct ice_aqc_alloc_free_res_elem *res_buf =
> +		 (struct ice_aqc_alloc_free_res_elem *)aq_buf;
> +	u16 type = (le16_to_cpu(res_buf->res_type) &
> +		    ICE_AQC_RES_TYPE_M) >> ICE_AQC_RES_TYPE_S;
> +
> +	if (type == ICE_AQC_RES_TYPE_VSI_LIST_REP)
> +		status = ice_dcf_parse_alloc_vsi_list_res(pf,
> +							  &res_buf-
> >elem[0]);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_dcf_handle_free_res_rsp - handle the free resource response
> + * @pf: pointer to the PF info
> + * @aq_buf: pointer to the free resource command buffer
> + */
> +static enum virtchnl_status_code
> +ice_dcf_handle_free_res_rsp(struct ice_pf *pf, u8 *aq_buf)
> +{
> +	enum virtchnl_status_code status = VIRTCHNL_STATUS_SUCCESS;
> +	struct ice_aqc_alloc_free_res_elem *res_buf =
> +		 (struct ice_aqc_alloc_free_res_elem *)aq_buf;
> +	u16 type = (le16_to_cpu(res_buf->res_type) &
> +		    ICE_AQC_RES_TYPE_M) >> ICE_AQC_RES_TYPE_S;
> +
> +	if (type == ICE_AQC_RES_TYPE_VSI_LIST_REP)
> +		status = ice_dcf_parse_free_vsi_list_res(pf,
> +							 &res_buf-
> >elem[0]);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_dcf_post_aq_send_cmd - get the data from firmware successful
> response
> + * @pf: pointer to the PF info
> + * @aq_desc: descriptor describing the command
> + * @aq_buf: the AdminQ command buffer
> + */
> +enum virtchnl_status_code
> +ice_dcf_post_aq_send_cmd(struct ice_pf *pf, struct ice_aq_desc
> *aq_desc,
> +			 u8 *aq_buf)
> +{
> +	enum virtchnl_status_code status = VIRTCHNL_STATUS_SUCCESS;
> +	u16 opc = le16_to_cpu(aq_desc->opcode);
> +
> +	if (!aq_buf)
> +		return VIRTCHNL_STATUS_SUCCESS;
> +
> +	if (opc == ice_aqc_opc_add_sw_rules)
> +		status = ice_dcf_handle_add_sw_rule_rsp(pf, aq_buf);
> +	else if (opc == ice_aqc_opc_update_sw_rules)
> +		status = ice_dcf_handle_updt_sw_rule_rsp(pf, aq_buf);
> +	else if (opc == ice_aqc_opc_remove_sw_rules)
> +		status = ice_dcf_handle_rm_sw_rule_rsp(pf, aq_buf);
> +	else if (opc == ice_aqc_opc_alloc_res)
> +		status = ice_dcf_handle_alloc_res_rsp(pf, aq_buf);
> +	else if (opc == ice_aqc_opc_free_res)
> +		status = ice_dcf_handle_free_res_rsp(pf, aq_buf);
> +
> +	return status;
> +}
> +
> +/**
> + * ice_dcf_pre_aq_send_cmd - check if it needs to send the command
> to firmware
> + * @vf: pointer to the VF info
> + * @aq_desc: descriptor describing the command
> + * @aq_buf: the AdminQ command buffer
> + * @aq_buf_size: the AdminQ command buffer size
> + */
> +bool
> +ice_dcf_pre_aq_send_cmd(struct ice_vf *vf, struct ice_aq_desc
> *aq_desc,
> +			u8 *aq_buf, u16 aq_buf_size)
> +{
> +	struct ice_pf *pf = vf->pf;
> +
> +	switch (le16_to_cpu(aq_desc->opcode)) {
> +	case ice_aqc_opc_update_sw_rules:
> +	{
> +		struct ice_dcf_vsi_list_info *vsi_list_info;
> +		struct ice_aqc_sw_rules_elem *s_rule;
> +		u16 list_id, vsi_id;
> +
> +		if (aq_buf_size < ICE_SW_RULE_VSI_LIST_SIZE(1))
> +			break;
> +
> +		s_rule = (struct ice_aqc_sw_rules_elem *)aq_buf;
> +		if (le16_to_cpu(s_rule->type) !=
> +					ICE_AQC_SW_RULES_T_VSI_LIST_CLE
> AR ||
> +		    le16_to_cpu(s_rule->pdata.vsi_list.number_vsi) !=
> 1)
> +			break;
> +
> +		list_id = le16_to_cpu(s_rule->pdata.vsi_list.index);
> +		vsi_list_info = ice_dcf_find_vsi_list_info(pf,
> list_id);
> +		if (!vsi_list_info)
> +			break;
> +
> +		vsi_id = le16_to_cpu(s_rule->pdata.vsi_list.vsi[0]);
> +		if (vsi_id >= ICE_HW_VSI_ID_MAX ||
> +		    test_bit(vsi_id, vsi_list_info->hw_vsi_map))
> +			break;
> +
> +		/* The VSI is removed from list already, no need to
> send the
> +		 * command to firmware.
> +		 */
> +		return true;
> +	}
> +	case ice_aqc_opc_remove_sw_rules:
> +	{
> +		struct ice_aqc_sw_rules_elem *s_rule;
> +		u16 rule_id;
> +
> +		if (aq_buf_size < ICE_SW_RULE_RX_TX_NO_HDR_SIZE)
> +			break;
> +
> +		s_rule = (struct ice_aqc_sw_rules_elem *)aq_buf;
> +		if (le16_to_cpu(s_rule->type) !=
> ICE_AQC_SW_RULES_T_LKUP_RX)
> +			break;
> +
> +		rule_id = le16_to_cpu(s_rule->pdata.lkup_tx_rx.index);
> +		if (ice_dcf_find_sw_rule(pf, rule_id))
> +			break;
> +
> +		/* The switch rule is removed already, no need to send
> the
> +		 * command to firmware.
> +		 */
> +		return true;
> +	}
> +
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_dcf.h
> b/drivers/net/ethernet/intel/ice/ice_dcf.h
> index 1ca228f89a19..23842db0a884 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcf.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dcf.h
> @@ -21,10 +21,42 @@ enum ice_dcf_state {
>  	ICE_DCF_STATE_PAUSE,
>  };
>  
> +struct ice_dcf_sw_rule_entry;
> +
> +#define ICE_HW_VSI_ID_MAX	BIT(10) /* The AQ VSI number uses 10
> bits */
> +
> +struct ice_dcf_vsi_list_info {
> +	struct list_head list_entry;
> +	struct ice_dcf_sw_rule_entry *sw_rule;
> +	u16 list_id;
> +
> +	u16 vsi_count;
> +	DECLARE_BITMAP(hw_vsi_map, ICE_HW_VSI_ID_MAX);
> +};
> +
> +struct ice_dcf_sw_rule_entry {
> +	struct list_head list_entry;
> +	u16 rule_id;
> +
> +	/* Only support ICE_FWD_TO_VSI and ICE_FWD_TO_VSI_LIST */
> +	enum ice_sw_fwd_act_type fltr_act;
> +	/* Depending on filter action */
> +	union {
> +		u16 hw_vsi_id:10;
> +		u16 vsi_list_id:10;
> +	} fwd_id;
> +
> +	struct ice_dcf_vsi_list_info *vsi_list_info;
> +};
> +
>  struct ice_dcf {
>  	struct ice_vf *vf;
>  	enum ice_dcf_state state;
>  
> +	/* Trace the switch rules added/removed by DCF */
> +	struct list_head sw_rule_head;
> +	struct list_head vsi_list_info_head;
> +
>  	/* Handle the AdminQ command between the DCF (Device Config
> Function)
>  	 * and the firmware.
>  	 */
> @@ -46,5 +78,14 @@ bool ice_check_dcf_allowed(struct ice_vf *vf);
>  bool ice_is_vf_dcf(struct ice_vf *vf);
>  enum ice_dcf_state ice_dcf_get_state(struct ice_pf *pf);
>  void ice_dcf_set_state(struct ice_pf *pf, enum ice_dcf_state state);
> +void ice_dcf_init_sw_rule_mgmt(struct ice_pf *pf);
> +void ice_rm_all_dcf_sw_rules(struct ice_pf *pf);
> +void ice_rm_dcf_sw_vsi_rule(struct ice_pf *pf, u16 hw_vsi_id);
> +bool
> +ice_dcf_pre_aq_send_cmd(struct ice_vf *vf, struct ice_aq_desc
> *aq_desc,
> +			u8 *aq_buf, u16 aq_buf_size);
> +enum virtchnl_status_code
> +ice_dcf_post_aq_send_cmd(struct ice_pf *pf, struct ice_aq_desc
> *aq_desc,
> +			 u8 *aq_buf);
>  #endif /* CONFIG_PCI_IOV */
>  #endif /* _ICE_DCF_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c
> b/drivers/net/ethernet/intel/ice/ice_switch.c
> index ccbe1cc64295..ee434b8d794d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -23,24 +23,10 @@
>   *	In case of Ether type filter it is treated as header without
> VLAN tag
>   *	and byte 12 and 13 is used to program a given Ether type
> instead
>   */
> -#define DUMMY_ETH_HDR_LEN		16
>  static const u8 dummy_eth_header[DUMMY_ETH_HDR_LEN] = { 0x2, 0, 0,
> 0, 0, 0,
>  							0x2, 0, 0, 0,
> 0, 0,
>  							0x81, 0, 0, 0};
>  
> -#define ICE_SW_RULE_RX_TX_ETH_HDR_SIZE \
> -	(offsetof(struct ice_aqc_sw_rules_elem, pdata.lkup_tx_rx.hdr) +
> \
> -	 (DUMMY_ETH_HDR_LEN * \
> -	  sizeof(((struct ice_sw_rule_lkup_rx_tx *)0)->hdr[0])))
> -#define ICE_SW_RULE_RX_TX_NO_HDR_SIZE \
> -	(offsetof(struct ice_aqc_sw_rules_elem, pdata.lkup_tx_rx.hdr))
> -#define ICE_SW_RULE_LG_ACT_SIZE(n) \
> -	(offsetof(struct ice_aqc_sw_rules_elem, pdata.lg_act.act) + \
> -	 ((n) * sizeof(((struct ice_sw_rule_lg_act *)0)->act[0])))
> -#define ICE_SW_RULE_VSI_LIST_SIZE(n) \
> -	(offsetof(struct ice_aqc_sw_rules_elem, pdata.vsi_list.vsi) + \
> -	 ((n) * sizeof(((struct ice_sw_rule_vsi_list *)0)->vsi[0])))
> -
>  /**
>   * ice_init_def_sw_recp - initialize the recipe book keeping tables
>   * @hw: pointer to the HW struct
> @@ -490,7 +476,7 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16
> *vsi_list_id,
>   *
>   * Add(0x02a0)/Update(0x02a1)/Remove(0x02a2) switch rules commands
> to firmware
>   */
> -static enum ice_status
> +enum ice_status
>  ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16
> rule_list_sz,
>  		u8 num_rules, enum ice_adminq_opc opc, struct ice_sq_cd
> *cd)
>  {

Hi Dave, Jakub,

This feature is only built when CONFIG_PCI_IOV is set. We end up with
this namespace issue using defconfig when checked against namespace.pl
since CONFIG_PCI_IOV is not enabled.
	Externally defined symbols with no external references
          ice_switch.o
            ice_aq_sw_rules

From a previous patch, neither of you liked the use of CONFIG_ to
control static-ness. I wanted to check that you are ok with the
namespace issue or if you have a preferred method to resolve this
issue. I appreciate your feedback.

Thanks,
Tony
