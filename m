From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 30 Apr 2016 13:24:55 +0300
Subject: [Intel-wired-lan] i40e: Add VF promiscuous mode driver support
Message-ID: <20160430102455.GA14020@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Anjali Singhai Jain,

The patch 5676a8b9cd9a: "i40e: Add VF promiscuous mode driver
support" from Apr 12, 2016, leads to the following static checker
warning:

	drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1550 i40e_vc_config_promiscuous_mode_msg()
	warn: curly braces intended?

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

  1536                  aq_ret = i40e_aq_set_vsi_uc_promisc_on_vlan(hw, vsi->seid,
  1537                                                              alluni,
  1538                                                              vf->port_vlan_id,
  1539                                                              NULL);
  1540          } else if (i40e_getnum_vf_vsi_vlan_filters(vsi)) {
  1541                  list_for_each_entry(f, &vsi->mac_filter_list, list) {
  1542                          aq_ret = 0;
  1543                          if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
  1544                                  aq_ret =
  1545                                  i40e_aq_set_vsi_uc_promisc_on_vlan(hw,
  1546                                                                     vsi->seid,
  1547                                                                     alluni,
  1548                                                                     f->vlan,
  1549                                                                     NULL);
  1550                                  aq_err = pf->hw.aq.asq_last_status;
  1551                          if (aq_ret)
  1552                                  dev_err(&pf->pdev->dev,
  1553                                          "Could not add VLAN %d to Unicast promiscuous domain err %s aq_err %s\n",
  1554                                          f->vlan,
  1555                                          i40e_stat_str(&pf->hw, aq_ret),
  1556                                          i40e_aq_str(&pf->hw, aq_err));

Curly braces were intended, but it doesn't affect run time.  This code
sort of convoluted and jammed up against the right side of the screen...

  1557                  }
  1558          } else {

regards,
dan carpenter
