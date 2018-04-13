From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Apr 2018 15:38:38 +0300
Subject: [Intel-wired-lan] [bug report] ice: Add support for VSI allocation
 and deallocation
Message-ID: <20180413123837.GA17689@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[ These are unpublished Smatch warnings because they're often false
  positives.  I'm reviewing these and I'm like 80% some are false
  positivies, but then I get to others and it feels 80% like they look
  buggy.  And in the end I don't know the code very well so I'm just
  going to forward all of them.  -- dan ]

Hello Anirudh Venkataramanan,

The patch 3a858ba392c3: "ice: Add support for VSI allocation and
deallocation" from Mar 20, 2018, leads to the following static
checker warning:

    drivers/net/ethernet/intel/ice/ice_main.c:1360 ice_set_dflt_vsi_ctx() warn: odd binop '0x0 & 0x18'

drivers/net/ethernet/intel/ice/ice_main.c
  1344  static void ice_set_dflt_vsi_ctx(struct ice_vsi_ctx *ctxt)
  1345  {
  1346          u32 table = 0;
  1347  
  1348          memset(&ctxt->info, 0, sizeof(ctxt->info));
  1349          /* VSI's should be allocated from shared pool */
  1350          ctxt->alloc_from_pool = true;
  1351          /* Src pruning enabled by default */
  1352          ctxt->info.sw_flags = ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
  1353          /* Traffic from VSI can be sent to LAN */
  1354          ctxt->info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
  1355          /* Allow all packets untagged/tagged */
  1356          ctxt->info.port_vlan_flags = ((ICE_AQ_VSI_PVLAN_MODE_ALL &
  1357                                         ICE_AQ_VSI_PVLAN_MODE_M) >>
  1358                                        ICE_AQ_VSI_PVLAN_MODE_S);
  1359          /* Show VLAN/UP from packets in Rx descriptors */
  1360          ctxt->info.port_vlan_flags |= ((ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH &
  1361                                          ICE_AQ_VSI_PVLAN_EMOD_M) >>

This probably should be | instead of &.

  1362                                         ICE_AQ_VSI_PVLAN_EMOD_S);
  1363          /* Have 1:1 UP mapping for both ingress/egress tables */
  1364          table |= ICE_UP_TABLE_TRANSLATE(0, 0);
  1365          table |= ICE_UP_TABLE_TRANSLATE(1, 1);
  1366          table |= ICE_UP_TABLE_TRANSLATE(2, 2);
  1367          table |= ICE_UP_TABLE_TRANSLATE(3, 3);
  1368          table |= ICE_UP_TABLE_TRANSLATE(4, 4);
  1369          table |= ICE_UP_TABLE_TRANSLATE(5, 5);
  1370          table |= ICE_UP_TABLE_TRANSLATE(6, 6);
  1371          table |= ICE_UP_TABLE_TRANSLATE(7, 7);
  1372          ctxt->info.ingress_table = cpu_to_le32(table);
  1373          ctxt->info.egress_table = cpu_to_le32(table);
  1374          /* Have 1:1 UP mapping for outer to inner UP table */
  1375          ctxt->info.outer_up_table = cpu_to_le32(table);
  1376          /* No Outer tag support outer_tag_flags remains to zero */
  1377  }

    drivers/net/ethernet/intel/ice/ice_main.c:2066 ice_req_irq_msix_misc() warn: odd binop '0x0 & 0x1800'
    drivers/net/ethernet/intel/ice/ice_main.c:2072 ice_req_irq_msix_misc() warn: odd binop '0x0 & 0x1800'

drivers/net/ethernet/intel/ice/ice_main.c
  2058                  ice_free_res(pf->irq_tracker, 1, ICE_RES_MISC_VEC_ID);
  2059                  return err;
  2060          }
  2061  
  2062  skip_req_irq:
  2063          ice_ena_misc_vector(pf);
  2064  
  2065          val = (pf->oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
  2066                (ICE_RX_ITR & PFINT_OICR_CTL_ITR_INDX_M) |
                       ^^^^^^^^^^
This is 0.  I had no idea what was intended here.  Possibly this is
fine?

  2067                PFINT_OICR_CTL_CAUSE_ENA_M;
  2068          wr32(hw, PFINT_OICR_CTL, val);
  2069  
  2070          /* This enables Admin queue Interrupt causes */
  2071          val = (pf->oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
  2072                (ICE_RX_ITR & PFINT_FW_CTL_ITR_INDX_M) |
                       ^^^^^^^^^^
Same.

  2073                PFINT_FW_CTL_CAUSE_ENA_M;
  2074          wr32(hw, PFINT_FW_CTL, val);
  2075  
  2076          itr_gran = hw->itr_gran_200;
  2077  
  2078          wr32(hw, GLINT_ITR(ICE_RX_ITR, pf->oicr_idx),
  2079               ITR_TO_REG(ICE_ITR_8K, itr_gran));
  2080  
  2081          ice_flush(hw);
  2082          ice_irq_dynamic_ena(hw, NULL, NULL);
  2083  
  2084          return 0;
  2085  }

drivers/net/ethernet/intel/ice/ice_common.c:1612 __ice_aq_get_set_rss_lut() warn: odd binop '0x0 & 0xc'

drivers/net/ethernet/intel/ice/ice_common.c
  1608  
  1609          /* LUT size is only valid for Global and PF table types */
  1610          if (lut_size == ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128) {
  1611                  flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG <<
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is zero.  I'm going to say it looks intentional.   (Feel free to
ignore these false positives.  Never change the code just to please the
static checker).

  1612                            ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
  1613                           ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
  1614          } else if (lut_size == ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512) {
  1615                  flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512_FLAG <<
  1616                            ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
  1617                           ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
  1618          } else if ((lut_size == ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K) &&
  1619                     (lut_type == ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF)) {
  1620                  flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K_FLAG <<
  1621                            ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
  1622                           ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
  1623          } else {
  1624                  status = ICE_ERR_PARAM;
  1625                  goto ice_aq_get_set_rss_lut_exit;
  1626          }
  1627  

drivers/net/ethernet/intel/ice/ice_switch.c:648 ice_add_marker_act() warn: odd binop '0x380000 & 0x7fff8'
drivers/net/ethernet/intel/ice/ice_switch.c:655 ice_add_marker_act() warn: odd binop '0x0 & 0x7fff8'

drivers/net/ethernet/intel/ice/ice_switch.c
   635          act = ICE_LG_ACT_VSI_FORWARDING | ICE_LG_ACT_VALID_BIT;
   636          act |= (vsi_info << ICE_LG_ACT_VSI_LIST_ID_S) &
   637                  ICE_LG_ACT_VSI_LIST_ID_M;
   638          if (m_ent->vsi_count > 1)
   639                  act |= ICE_LG_ACT_VSI_LIST;
   640          lg_act->pdata.lg_act.act[0] = cpu_to_le32(act);
   641  
   642          /* Second action descriptor type */
   643          act = ICE_LG_ACT_GENERIC;
   644  
   645          act |= (1 << ICE_LG_ACT_GENERIC_VALUE_S) & ICE_LG_ACT_GENERIC_VALUE_M;
   646          lg_act->pdata.lg_act.act[1] = cpu_to_le32(act);
   647  
   648          act = (7 << ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_VALUE_M;
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This feels buggy, but I have no idea what was intended.

   649  
   650          /* Third action Marker value */
   651          act |= ICE_LG_ACT_GENERIC;
   652          act |= (sw_marker << ICE_LG_ACT_GENERIC_VALUE_S) &
   653                  ICE_LG_ACT_GENERIC_VALUE_M;
   654  
   655          act |= (0 << ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_VALUE_M;
                        ^

Obviously intended, but I feel like the literal 0 doesn't add anything
in terms of making it more readable...

   656          lg_act->pdata.lg_act.act[2] = cpu_to_le32(act);
   657  
   658          /* call the fill switch rule to fill the lookup tx rx structure */
   659          ice_fill_sw_rule(hw, &m_ent->fltr_info, rx_tx,
   660                           ice_aqc_opc_update_sw_rules);
   661  
   662          /* Update the action to point to the large action id */
   663          rx_tx->pdata.lkup_tx_rx.act =
   664                  cpu_to_le32(ICE_SINGLE_ACT_PTR |
   665                              ((l_id << ICE_SINGLE_ACT_PTR_VAL_S) &
   666                               ICE_SINGLE_ACT_PTR_VAL_M));

regards,
dan carpenter
