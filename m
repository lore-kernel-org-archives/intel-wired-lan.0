From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 21 Jun 2018 16:19:36 +0300
Subject: [Intel-wired-lan] [bug report] ice: Add support for switch filter
 programming
Message-ID: <20180621131935.7cmmi33dzqg5x7o5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[ This test suddenly started generating a lot of warnings...  I'm not
  sure how much I trust them.  - dan ]

Hello Anirudh Venkataramanan,

This is a semi-automatic email about new static checker warnings.

The patch 9daf8208dd4d: "ice: Add support for switch filter 
programming" from Mar 20, 2018, leads to the following Smatch 
complaint:

    drivers/net/ethernet/intel/ice/ice_switch.c:1021 ice_handle_vsi_list_mgmt()
     error: we previously assumed 'm_entry->vsi_list_info' could be null (see line 973)

drivers/net/ethernet/intel/ice/ice_switch.c
   972	
   973		if (m_entry->vsi_count < 2 && !m_entry->vsi_list_info) {
                    ^^^^^^^^^^^^^^^^^^^^^^
I guess Smatch is complaining that m_entry->vsi_count can be 2 and
m_entry->vsi_list_info can be NULL?

   974			/* Only one entry existed in the mapping and it was not already
   975			 * a part of a VSI list. So, create a VSI list with the old and
   976			 * new VSIs.
   977			 */
   978			u16 vsi_id_arr[2];
   979			u16 fltr_rule;
   980	
   981			/* A rule already exists with the new VSI being added */
   982			if (cur_fltr->fwd_id.vsi_id == new_fltr->fwd_id.vsi_id)
   983				return ICE_ERR_ALREADY_EXISTS;
   984	
   985			vsi_id_arr[0] = cur_fltr->fwd_id.vsi_id;
   986			vsi_id_arr[1] = new_fltr->fwd_id.vsi_id;
   987			status = ice_create_vsi_list_rule(hw, &vsi_id_arr[0], 2,
   988							  &vsi_list_id,
   989							  new_fltr->lkup_type);
   990			if (status)
   991				return status;
   992	
   993			fltr_rule = cur_fltr->fltr_rule_id;
   994			/* Update the previous switch rule of "MAC forward to VSI" to
   995			 * "MAC fwd to VSI list"
   996			 */
   997			status = ice_update_pkt_fwd_rule(hw, fltr_rule, vsi_list_id,
   998							 *new_fltr);
   999			if (status)
  1000				return status;
  1001	
  1002			cur_fltr->fwd_id.vsi_list_id = vsi_list_id;
  1003			cur_fltr->fltr_act = ICE_FWD_TO_VSI_LIST;
  1004			m_entry->vsi_list_info =
  1005				ice_create_vsi_list_map(hw, &vsi_id_arr[0], 2,
  1006							vsi_list_id);
  1007	
  1008			/* If this entry was large action then the large action needs
  1009			 * to be updated to point to FWD to VSI list
  1010			 */
  1011			if (m_entry->sw_marker_id != ICE_INVAL_SW_MARKER_ID)
  1012				status =
  1013				    ice_add_marker_act(hw, m_entry,
  1014						       m_entry->sw_marker_id,
  1015						       m_entry->lg_act_idx);
  1016		} else {
  1017			u16 vsi_id = new_fltr->fwd_id.vsi_id;
  1018			enum ice_adminq_opc opcode;
  1019	
  1020			/* A rule already exists with the new VSI being added */
  1021			if (test_bit(vsi_id, m_entry->vsi_list_info->vsi_map))
                                             ^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

  1022				return 0;
  1023	

regards,
dan carpenter
