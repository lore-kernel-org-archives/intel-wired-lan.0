From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 19 Aug 2019 15:02:28 +0300
Subject: [Intel-wired-lan] [bug report] i40e: Log info when PF is entering
 and leaving Allmulti mode.
Message-ID: <20190819120228.GA27099@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Czeslaw Zagorski,

The patch b603f9dc20af: "i40e: Log info when PF is entering and
leaving Allmulti mode." from Jul 2, 2019, leads to the following
static checker warning:

	drivers/net/ethernet/intel/i40e/i40e_main.c:2534 i40e_sync_vsi_filters()
	error: we previously assumed 'vsi->netdev' could be null (see line 2286)

drivers/net/ethernet/intel/i40e/i40e_main.c
  2254  int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
  2255  {
  2256          struct hlist_head tmp_add_list, tmp_del_list;
  2257          struct i40e_mac_filter *f;
  2258          struct i40e_new_mac_filter *new, *add_head = NULL;
  2259          struct i40e_hw *hw = &vsi->back->hw;
  2260          bool old_overflow, new_overflow;
  2261          unsigned int failed_filters = 0;
  2262          unsigned int vlan_filters = 0;
  2263          char vsi_name[16] = "PF";
  2264          int filter_list_len = 0;
  2265          i40e_status aq_ret = 0;
  2266          u32 changed_flags = 0;
  2267          struct hlist_node *h;
  2268          struct i40e_pf *pf;
  2269          int num_add = 0;
  2270          int num_del = 0;
  2271          int retval = 0;
  2272          u16 cmd_flags;
  2273          int list_size;
  2274          int bkt;
  2275  
  2276          /* empty array typed pointers, kcalloc later */
  2277          struct i40e_aqc_add_macvlan_element_data *add_list;
  2278          struct i40e_aqc_remove_macvlan_element_data *del_list;
  2279  
  2280          while (test_and_set_bit(__I40E_VSI_SYNCING_FILTERS, vsi->state))
  2281                  usleep_range(1000, 2000);
  2282          pf = vsi->back;
  2283  
  2284          old_overflow = test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
  2285  
  2286          if (vsi->netdev) {
                    ^^^^^^^^^^^
The existing code assumes that this can be NULL.

  2287                  changed_flags = vsi->current_netdev_flags ^ vsi->netdev->flags;
  2288                  vsi->current_netdev_flags = vsi->netdev->flags;
  2289          }
  2290  

[ snip ]

  2516          /* check for changes in promiscuous modes */
  2517          if (changed_flags & IFF_ALLMULTI) {
  2518                  bool cur_multipromisc;
  2519  
  2520                  cur_multipromisc = !!(vsi->current_netdev_flags & IFF_ALLMULTI);
  2521                  aq_ret = i40e_aq_set_vsi_multicast_promiscuous(&vsi->back->hw,
  2522                                                                 vsi->seid,
  2523                                                                 cur_multipromisc,
  2524                                                                 NULL);
  2525                  if (aq_ret) {
  2526                          retval = i40e_aq_rc_to_posix(aq_ret,
  2527                                                       hw->aq.asq_last_status);
  2528                          dev_info(&pf->pdev->dev,
  2529                                   "set multi promisc failed on %s, err %s aq_err %s\n",
  2530                                   vsi_name,
  2531                                   i40e_stat_str(hw, aq_ret),
  2532                                   i40e_aq_str(hw, hw->aq.asq_last_status));
  2533                  } else {
  2534                          dev_info(&pf->pdev->dev, "%s is %s allmulti mode.\n",
  2535                                   vsi->netdev->name,
                                         ^^^^^^^^^^^^^^^^^
Unchecked dereference.  Do you want to use vsi_name instead?

  2536                                   cur_multipromisc ? "entering" : "leaving");
  2537                  }
  2538          }

regards,
dan carpenter
