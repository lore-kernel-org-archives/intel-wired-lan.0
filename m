From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 11 Jan 2022 21:56:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 2/4] i40e: Add new version
 of i40e_aq_add_macvlan function
In-Reply-To: <20220110131142.8481-3-jedrzej.jagielski@intel.com>
References: <20220110131142.8481-1-jedrzej.jagielski@intel.com>
 <20220110131142.8481-3-jedrzej.jagielski@intel.com>
Message-ID: <571acb2a7885338ccde1347a6ee92bad02fa9178.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2022-01-10 at 13:11 +0000, Jedrzej Jagielski wrote:

<snip>

> +/**
> + * i40e_aq_add_macvlan
> + * @hw: pointer to the hw struct
> + * @seid: VSI for the mac address
> + * @mv_list: list of macvlans to be added
> + * @count: length of the list
> + * @cmd_details: pointer to command details structure or NULL
> + *
> + * Add MAC/VLAN addresses to the HW filtering
> + **/
> +i40e_status
> +i40e_aq_add_macvlan(struct i40e_hw *hw, u16 seid,
> +?????????????????? struct i40e_aqc_add_macvlan_element_data
> *mv_list,
> +?????????????????? u16 count, struct i40e_asq_cmd_details
> *cmd_details)
> +{
> +???????struct i40e_aq_desc desc;
> +???????i40e_status status;
> +???????u16 buf_size;
> +
> +???????if (count == 0 || !mv_list || !hw)
> +???????????????return I40E_ERR_PARAM;
> +
> +???????buf_size = i40e_prepare_add_macvlan(mv_list, &desc, count,
> seid);
> ?
> ????????status = i40e_asq_send_command(hw, &desc, mv_list, buf_size,
> ?????????????????????????????????????? cmd_details);

Not directly part of this patch, but if you are touching this function.
This function could also be returned directly since the line directly
following this is a 'return status'.

> @@ -2679,6 +2701,42 @@ i40e_status i40e_aq_add_macvlan(struct i40e_hw
> *hw, u16 seid,
> ????????return status;
> ?}
> ?
> +/**
> + * i40e_aq_add_macvlan_v2
> + * @hw: pointer to the hw struct
> + * @seid: VSI for the mac address
> + * @mv_list: list of macvlans to be added
> + * @count: length of the list
> + * @cmd_details: pointer to command details structure or NULL
> + * @aq_status: pointer to Admin Queue status return value
> + *
> + * Add MAC/VLAN addresses to the HW filtering.
> + * The _v2 version returns the last Admin Queue status in aq_status
> + * to avoid race conditions in access to hw->aq.asq_last_status.
> + * It also calls _v2 versions of asq_send_command functions to
> + * get the aq_status on the stack.
> + **/
> +i40e_status
> +i40e_aq_add_macvlan_v2(struct i40e_hw *hw, u16 seid,
> +????????????????????? struct i40e_aqc_add_macvlan_element_data
> *mv_list,
> +????????????????????? u16 count, struct i40e_asq_cmd_details
> *cmd_details,
> +????????????????????? enum i40e_admin_queue_err *aq_status)
> +{
> +???????struct i40e_aq_desc desc;
> +???????i40e_status status;
> +???????u16 buf_size;
> +
> +???????if (count == 0 || !mv_list || !hw)
> +???????????????return I40E_ERR_PARAM;
> +
> +???????buf_size = i40e_prepare_add_macvlan(mv_list, &desc, count,
> seid);
> +
> +???????status = i40e_asq_send_command_atomic_v2(hw, &desc, mv_list,
> buf_size,
> +??????????????????????????????????????????????? cmd_details, true,
> aq_status);
> +
> +???????return status;

Same here. This function can be returned direclty and status removed.

> +}
> +

