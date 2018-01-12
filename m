From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 13 Jan 2018 07:19:07 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 109/109]
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3017:43: sparse:
 restricted __be16 degrades to integer
Message-ID: <201801130740.nIajnAAm%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5a2f5288e8033ca6995630146eb61790471d9542
commit: 5a2f5288e8033ca6995630146eb61790471d9542 [109/109] i40e: Add and delete cloud filter
reproduce:
        # apt-get install sparse
        git checkout 5a2f5288e8033ca6995630146eb61790471d9542
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3017:43: sparse: restricted __be16 degrades to integer
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3025:43: sparse: restricted __be16 degrades to integer
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3057:17: sparse: symbol 'i40e_find_vsi_from_seid' was not declared. Should it be
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3077:6: sparse: symbol 'i40e_del_all_cloud_filters' was not declared. Should it be

Please review and possibly fold the followup patch.

vim +3017 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

  2918	
  2919	/**
  2920	 * i40e_validate_cloud_filter
  2921	 * @mask: mask for TC filter
  2922	 * @data: data for TC filter
  2923	 *
  2924	 * This function validates cloud filter programmed as TC filter for ADq
  2925	 **/
  2926	static int i40e_validate_cloud_filter(struct i40e_vf *vf,
  2927					      struct virtchnl_filter *tc_filter)
  2928	{
  2929		struct virtchnl_l4_spec mask = tc_filter->mask.tcp_spec;
  2930		struct virtchnl_l4_spec data = tc_filter->data.tcp_spec;
  2931		struct i40e_pf *pf = vf->pf;
  2932		struct i40e_vsi *vsi = NULL;
  2933		struct i40e_mac_filter *f;
  2934		struct hlist_node *h;
  2935		bool found = false;
  2936		int bkt;
  2937	
  2938		if (!tc_filter->action) {
  2939			dev_info(&pf->pdev->dev,
  2940				 "VF %d: Currently ADq doesn't support Drop Action\n",
  2941				 vf->vf_id);
  2942			goto err;
  2943		}
  2944	
  2945		/* action_meta is TC number here to which the filter is applied */
  2946		if (!tc_filter->action_meta ||
  2947		    tc_filter->action_meta > I40E_MAX_VF_VSI) {
  2948			dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
  2949				 vf->vf_id, tc_filter->action_meta);
  2950			goto err;
  2951		}
  2952	
  2953		/* Check filter if it's programmed for advanced mode or basic mode.
  2954		 * There are two ADq modes (for VF only),
  2955		 * 1. Basic mode: intended to allow as many filter options as posssible
  2956		 *		  to be added to a VF in Non-trusted mode. Main goal is
  2957		 *		  to add filters to its own MAC and VLAN id.
  2958		 * 2. Advanced mode: is for allowing filters to be applied other than
  2959		 *		  its own MAC or VLAN. This mode requires the VF to be
  2960		 *		  Trusted.
  2961		 */
  2962		if (mask.dst_mac[0] && !mask.dst_ip[0]) {
  2963			vsi = pf->vsi[vf->lan_vsi_idx];
  2964			f = i40e_find_mac(vsi, data.dst_mac);
  2965	
  2966			if (!f) {
  2967				dev_info(&pf->pdev->dev,
  2968					 "Destination MAC %pM doesn't belong to VF %d\n",
  2969					 data.dst_mac, vf->vf_id);
  2970				goto err;
  2971			}
  2972	
  2973			if (mask.vlan_id) {
  2974				hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f,
  2975						   hlist) {
  2976					if (f->vlan == ntohs(data.vlan_id)) {
  2977						found = true;
  2978						break;
  2979					}
  2980				}
  2981				if (!found) {
  2982					dev_info(&pf->pdev->dev,
  2983						 "VF %d doesn't have any VLAN id %u\n",
  2984						 vf->vf_id, ntohs(data.vlan_id));
  2985					goto err;
  2986				}
  2987			}
  2988		} else {
  2989			/* Check if VF is trusted */
  2990			if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
  2991				dev_err(&pf->pdev->dev,
  2992					"VF %d not trusted, make VF trusted to add advanced mode ADq cloud filters\n",
  2993					vf->vf_id);
  2994				return I40E_ERR_CONFIG;
  2995			}
  2996		}
  2997	
  2998		if (mask.dst_mac[0] & data.dst_mac[0]) {
  2999			if (is_broadcast_ether_addr(data.dst_mac) ||
  3000			    is_zero_ether_addr(data.dst_mac)) {
  3001				dev_info(&pf->pdev->dev, "VF %d: Invalid Dest MAC addr %pM\n",
  3002					 vf->vf_id, data.dst_mac);
  3003				goto err;
  3004			}
  3005		}
  3006	
  3007		if (mask.src_mac[0] & data.src_mac[0]) {
  3008			if (is_broadcast_ether_addr(data.src_mac) ||
  3009			    is_zero_ether_addr(data.src_mac)) {
  3010				dev_info(&pf->pdev->dev, "VF %d: Invalid Source MAC addr %pM\n",
  3011					 vf->vf_id, data.src_mac);
  3012				goto err;
  3013			}
  3014		}
  3015	
  3016		if (mask.dst_port & data.dst_port) {
> 3017			if (!data.dst_port || data.dst_port > 0xFFFF) {
  3018				dev_info(&pf->pdev->dev, "VF %d: Invalid Dest port\n",
  3019					 vf->vf_id);
  3020				goto err;
  3021			}
  3022		}
  3023	
  3024		if (mask.src_port & data.src_port) {
  3025			if (!data.src_port || data.src_port > 0xFFFF) {
  3026				dev_info(&pf->pdev->dev, "VF %d: Invalid Source port\n",
  3027					 vf->vf_id);
  3028				goto err;
  3029			}
  3030		}
  3031	
  3032		if (tc_filter->flow_type != VIRTCHNL_TCP_V6_FLOW &&
  3033		    tc_filter->flow_type != VIRTCHNL_TCP_V4_FLOW) {
  3034			dev_info(&pf->pdev->dev, "VF %d: Invalid Flow type\n",
  3035				 vf->vf_id);
  3036			goto err;
  3037		}
  3038	
  3039		if (mask.vlan_id & data.vlan_id) {
  3040			if (ntohs(data.vlan_id) > I40E_MAX_VLANID) {
  3041				dev_info(&pf->pdev->dev, "VF %d: invalid VLAN ID\n",
  3042					 vf->vf_id);
  3043				goto err;
  3044			}
  3045		}
  3046	
  3047		return I40E_SUCCESS;
  3048	err:
  3049		return I40E_ERR_CONFIG;
  3050	}
  3051	
  3052	/**
  3053	 * i40e_find_vsi_from_seid - searches for the vsi with the given seid
  3054	 * @vf: pointer to the VF info
  3055	 * @seid - seid of the vsi it is searching for
  3056	 **/
> 3057	struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
  3058	{
  3059		struct i40e_pf *pf = vf->pf;
  3060		struct i40e_vsi *vsi = NULL;
  3061		int i;
  3062	
  3063		for (i = 0; i < vf->num_tc ; i++) {
  3064			vsi = i40e_find_vsi_from_id(pf, vf->ch[i].vsi_id);
  3065			if (vsi->seid == seid)
  3066				return vsi;
  3067		}
  3068		return NULL;
  3069	}
  3070	
  3071	/**
  3072	 * i40e_del_all_cloud_filters
  3073	 * @vf: pointer to the VF info
  3074	 *
  3075	 * This function deletes all cloud filters
  3076	 **/
> 3077	void i40e_del_all_cloud_filters(struct i40e_vf *vf)
  3078	{
  3079		struct i40e_cloud_filter *cfilter = NULL;
  3080		struct i40e_pf *pf = vf->pf;
  3081		struct i40e_vsi *vsi = NULL;
  3082		struct hlist_node *node;
  3083		int ret;
  3084	
  3085		hlist_for_each_entry_safe(cfilter, node,
  3086					  &vf->cloud_filter_list, cloud_node) {
  3087			vsi = i40e_find_vsi_from_seid(vf, cfilter->seid);
  3088	
  3089			if (!vsi) {
  3090				dev_err(&pf->pdev->dev, "VF %d: no VSI found for matching %u seid, can't delete cloud filter\n",
  3091					vf->vf_id, cfilter->seid);
  3092				continue;
  3093			}
  3094	
  3095			if (cfilter->dst_port)
  3096				ret = i40e_add_del_cloud_filter_big_buf(vsi, cfilter,
  3097									false);
  3098			else
  3099				ret = i40e_add_del_cloud_filter(vsi, cfilter, false);
  3100			if (ret)
  3101				dev_err(&pf->pdev->dev,
  3102					"VF %d: Failed to delete cloud filter, err %s aq_err %s\n",
  3103					vf->vf_id, i40e_stat_str(&pf->hw, ret),
  3104					i40e_aq_str(&pf->hw,
  3105						    pf->hw.aq.asq_last_status));
  3106	
  3107			hlist_del(&cfilter->cloud_node);
  3108			kfree(cfilter);
  3109			vf->num_cloud_filters--;
  3110		}
  3111	}
  3112	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
