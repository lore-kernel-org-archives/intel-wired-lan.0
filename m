From: kbuild test robot <lkp@intel.com>
Date: Mon, 25 Jun 2018 15:30:59 +0300
Subject: [Intel-wired-lan] [PATCH v3 11/11] igc: Add watchdog
In-Reply-To: <20180624084528.10419-1-sasha.neftin@intel.com>
Message-ID: <20180625123059.iuc7pshinltl55e5@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Sasha-Neftin/igc-Add-skeletal-frame-for-Intel-R-2-5G-Ethernet-Controller-support/20180624-164739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue

smatch warnings:
drivers/net/ethernet/intel/igc/igc_main.c:2464 igc_watchdog_task() error: uninitialized symbol 'phy_data'.

# https://github.com/0day-ci/linux/commit/d32b0b485e39c7c5a2ef4e9484919d6fa6a6733e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d32b0b485e39c7c5a2ef4e9484919d6fa6a6733e
vim +/phy_data +2464 drivers/net/ethernet/intel/igc/igc_main.c

3e307bfc Sasha Neftin 2018-06-24  2382  
d32b0b48 Sasha Neftin 2018-06-24  2383  static void igc_watchdog_task(struct work_struct *work)
d32b0b48 Sasha Neftin 2018-06-24  2384  {
d32b0b48 Sasha Neftin 2018-06-24  2385  	struct igc_adapter *adapter = container_of(work,
d32b0b48 Sasha Neftin 2018-06-24  2386  						   struct igc_adapter,
d32b0b48 Sasha Neftin 2018-06-24  2387  						   watchdog_task);
d32b0b48 Sasha Neftin 2018-06-24  2388  	struct e1000_hw *hw = &adapter->hw;
d32b0b48 Sasha Neftin 2018-06-24  2389  	struct e1000_phy_info *phy = &hw->phy;
d32b0b48 Sasha Neftin 2018-06-24  2390  	struct net_device *netdev = adapter->netdev;
d32b0b48 Sasha Neftin 2018-06-24  2391  	u32 link;
d32b0b48 Sasha Neftin 2018-06-24  2392  	int i;
d32b0b48 Sasha Neftin 2018-06-24  2393  	u32 connsw;
d32b0b48 Sasha Neftin 2018-06-24  2394  	u16 phy_data, retry_count = 20;
d32b0b48 Sasha Neftin 2018-06-24  2395  
d32b0b48 Sasha Neftin 2018-06-24  2396  	link = igc_has_link(adapter);
d32b0b48 Sasha Neftin 2018-06-24  2397  
d32b0b48 Sasha Neftin 2018-06-24  2398  	if (adapter->flags & IGC_FLAG_NEED_LINK_UPDATE) {
d32b0b48 Sasha Neftin 2018-06-24  2399  		if (time_after(jiffies, (adapter->link_check_timeout + HZ)))
d32b0b48 Sasha Neftin 2018-06-24  2400  			adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
d32b0b48 Sasha Neftin 2018-06-24  2401  		else
d32b0b48 Sasha Neftin 2018-06-24  2402  			link = false;
d32b0b48 Sasha Neftin 2018-06-24  2403  	}
d32b0b48 Sasha Neftin 2018-06-24  2404  
d32b0b48 Sasha Neftin 2018-06-24  2405  	/* Force link down if we have fiber to swap to */
d32b0b48 Sasha Neftin 2018-06-24  2406  	if (adapter->flags & IGC_FLAG_MAS_ENABLE) {
d32b0b48 Sasha Neftin 2018-06-24  2407  		if (hw->phy.media_type == e1000_media_type_copper) {
d32b0b48 Sasha Neftin 2018-06-24  2408  			connsw = rd32(E1000_CONNSW);
d32b0b48 Sasha Neftin 2018-06-24  2409  			if (!(connsw & E1000_CONNSW_AUTOSENSE_EN))
d32b0b48 Sasha Neftin 2018-06-24  2410  				link = 0;
d32b0b48 Sasha Neftin 2018-06-24  2411  		}
d32b0b48 Sasha Neftin 2018-06-24  2412  	}
d32b0b48 Sasha Neftin 2018-06-24  2413  	if (link) {
d32b0b48 Sasha Neftin 2018-06-24  2414  		/* Perform a reset if the media type changed. */
d32b0b48 Sasha Neftin 2018-06-24  2415  		if (hw->dev_spec._base.media_changed) {
d32b0b48 Sasha Neftin 2018-06-24  2416  			hw->dev_spec._base.media_changed = false;
d32b0b48 Sasha Neftin 2018-06-24  2417  			adapter->flags |= IGC_FLAG_MEDIA_RESET;
d32b0b48 Sasha Neftin 2018-06-24  2418  			igc_reset(adapter);
d32b0b48 Sasha Neftin 2018-06-24  2419  		}
d32b0b48 Sasha Neftin 2018-06-24  2420  
d32b0b48 Sasha Neftin 2018-06-24  2421  		if (!netif_carrier_ok(netdev)) {
d32b0b48 Sasha Neftin 2018-06-24  2422  			u32 ctrl;
d32b0b48 Sasha Neftin 2018-06-24  2423  
d32b0b48 Sasha Neftin 2018-06-24  2424  			hw->mac.ops.get_speed_and_duplex(hw,
d32b0b48 Sasha Neftin 2018-06-24  2425  							 &adapter->link_speed,
d32b0b48 Sasha Neftin 2018-06-24  2426  							 &adapter->link_duplex);
d32b0b48 Sasha Neftin 2018-06-24  2427  
d32b0b48 Sasha Neftin 2018-06-24  2428  			ctrl = rd32(E1000_CTRL);
d32b0b48 Sasha Neftin 2018-06-24  2429  			/* Links status message must follow this format */
d32b0b48 Sasha Neftin 2018-06-24  2430  			netdev_info(netdev,
d32b0b48 Sasha Neftin 2018-06-24  2431  				    "igc: %s NIC Link is Up %d Mbps %s Duplex, Flow Control: %s\n",
d32b0b48 Sasha Neftin 2018-06-24  2432  				    netdev->name,
d32b0b48 Sasha Neftin 2018-06-24  2433  				    adapter->link_speed,
d32b0b48 Sasha Neftin 2018-06-24  2434  				    adapter->link_duplex == FULL_DUPLEX ?
d32b0b48 Sasha Neftin 2018-06-24  2435  				    "Full" : "Half",
d32b0b48 Sasha Neftin 2018-06-24  2436  				    (ctrl & E1000_CTRL_TFCE) &&
d32b0b48 Sasha Neftin 2018-06-24  2437  				    (ctrl & E1000_CTRL_RFCE) ? "RX/TX" :
d32b0b48 Sasha Neftin 2018-06-24  2438  				    (ctrl & E1000_CTRL_RFCE) ?  "RX" :
d32b0b48 Sasha Neftin 2018-06-24  2439  				    (ctrl & E1000_CTRL_TFCE) ?  "TX" : "None");
d32b0b48 Sasha Neftin 2018-06-24  2440  
d32b0b48 Sasha Neftin 2018-06-24  2441  			/* check if SmartSpeed worked */
d32b0b48 Sasha Neftin 2018-06-24  2442  			igc_check_downshift(hw);
d32b0b48 Sasha Neftin 2018-06-24  2443  			if (phy->speed_downgraded)
d32b0b48 Sasha Neftin 2018-06-24  2444  				netdev_warn(netdev, "Link Speed was downgraded by SmartSpeed\n");
d32b0b48 Sasha Neftin 2018-06-24  2445  
d32b0b48 Sasha Neftin 2018-06-24  2446  			/* adjust timeout factor according to speed/duplex */
d32b0b48 Sasha Neftin 2018-06-24  2447  			adapter->tx_timeout_factor = 1;
d32b0b48 Sasha Neftin 2018-06-24  2448  			switch (adapter->link_speed) {
d32b0b48 Sasha Neftin 2018-06-24  2449  			case SPEED_10:
d32b0b48 Sasha Neftin 2018-06-24  2450  				adapter->tx_timeout_factor = 14;
d32b0b48 Sasha Neftin 2018-06-24  2451  				break;
d32b0b48 Sasha Neftin 2018-06-24  2452  			case SPEED_100:
d32b0b48 Sasha Neftin 2018-06-24  2453  				/* maybe add some timeout factor ? */
d32b0b48 Sasha Neftin 2018-06-24  2454  				break;
d32b0b48 Sasha Neftin 2018-06-24  2455  			}
d32b0b48 Sasha Neftin 2018-06-24  2456  
d32b0b48 Sasha Neftin 2018-06-24  2457  			if (adapter->link_speed != SPEED_1000)
d32b0b48 Sasha Neftin 2018-06-24  2458  				goto no_wait;
d32b0b48 Sasha Neftin 2018-06-24  2459  
d32b0b48 Sasha Neftin 2018-06-24  2460  			/* wait for Remote receiver status OK */
d32b0b48 Sasha Neftin 2018-06-24  2461  retry_read_status:
d32b0b48 Sasha Neftin 2018-06-24  2462  			if (!igc_read_phy_reg(hw, PHY_1000T_STATUS,
                                                                     ^^^^^^^^^^^^^^^^
If the function isn't implemented the this returns success without initializing "phy_data".

d32b0b48 Sasha Neftin 2018-06-24  2463  					      &phy_data)) {
d32b0b48 Sasha Neftin 2018-06-24 @2464  				if (!(phy_data & SR_1000T_REMOTE_RX_STATUS) &&
                                                                              ^^^^^^^^
d32b0b48 Sasha Neftin 2018-06-24  2465  				    retry_count) {
d32b0b48 Sasha Neftin 2018-06-24  2466  					msleep(100);
d32b0b48 Sasha Neftin 2018-06-24  2467  					retry_count--;
d32b0b48 Sasha Neftin 2018-06-24  2468  					goto retry_read_status;
d32b0b48 Sasha Neftin 2018-06-24  2469  				} else if (!retry_count) {
d32b0b48 Sasha Neftin 2018-06-24  2470  					dev_err(&adapter->pdev->dev, "exceed max 2 second\n");
d32b0b48 Sasha Neftin 2018-06-24  2471  				}
d32b0b48 Sasha Neftin 2018-06-24  2472  			} else {
d32b0b48 Sasha Neftin 2018-06-24  2473  				dev_err(&adapter->pdev->dev, "read 1000Base-T Status Reg\n");
d32b0b48 Sasha Neftin 2018-06-24  2474  			}
d32b0b48 Sasha Neftin 2018-06-24  2475  no_wait:
d32b0b48 Sasha Neftin 2018-06-24  2476  			netif_carrier_on(netdev);
d32b0b48 Sasha Neftin 2018-06-24  2477  
d32b0b48 Sasha Neftin 2018-06-24  2478  			/* link state has changed, schedule phy info update */
d32b0b48 Sasha Neftin 2018-06-24  2479  			if (!test_bit(__IGC_DOWN, &adapter->state))
d32b0b48 Sasha Neftin 2018-06-24  2480  				mod_timer(&adapter->phy_info_timer,
d32b0b48 Sasha Neftin 2018-06-24  2481  					  round_jiffies(jiffies + 2 * HZ));
d32b0b48 Sasha Neftin 2018-06-24  2482  		}
d32b0b48 Sasha Neftin 2018-06-24  2483  	} else {
d32b0b48 Sasha Neftin 2018-06-24  2484  		if (netif_carrier_ok(netdev)) {
d32b0b48 Sasha Neftin 2018-06-24  2485  			adapter->link_speed = 0;
d32b0b48 Sasha Neftin 2018-06-24  2486  			adapter->link_duplex = 0;
d32b0b48 Sasha Neftin 2018-06-24  2487  
d32b0b48 Sasha Neftin 2018-06-24  2488  			/* Links status message must follow this format */
d32b0b48 Sasha Neftin 2018-06-24  2489  			netdev_info(netdev, "igc: %s NIC Link is Down\n",
d32b0b48 Sasha Neftin 2018-06-24  2490  				    netdev->name);
d32b0b48 Sasha Neftin 2018-06-24  2491  			netif_carrier_off(netdev);
d32b0b48 Sasha Neftin 2018-06-24  2492  
d32b0b48 Sasha Neftin 2018-06-24  2493  			/* link state has changed, schedule phy info update */
d32b0b48 Sasha Neftin 2018-06-24  2494  			if (!test_bit(__IGC_DOWN, &adapter->state))
d32b0b48 Sasha Neftin 2018-06-24  2495  				mod_timer(&adapter->phy_info_timer,
d32b0b48 Sasha Neftin 2018-06-24  2496  					  round_jiffies(jiffies + 2 * HZ));
d32b0b48 Sasha Neftin 2018-06-24  2497  
d32b0b48 Sasha Neftin 2018-06-24  2498  			/* link is down, time to check for alternate media */
d32b0b48 Sasha Neftin 2018-06-24  2499  			if (adapter->flags & IGC_FLAG_MAS_ENABLE) {
d32b0b48 Sasha Neftin 2018-06-24  2500  				igc_check_swap_media(adapter);
d32b0b48 Sasha Neftin 2018-06-24  2501  				if (adapter->flags & IGC_FLAG_MEDIA_RESET) {
d32b0b48 Sasha Neftin 2018-06-24  2502  					schedule_work(&adapter->reset_task);
d32b0b48 Sasha Neftin 2018-06-24  2503  					/* return immediately */
d32b0b48 Sasha Neftin 2018-06-24  2504  					return;
d32b0b48 Sasha Neftin 2018-06-24  2505  				}
d32b0b48 Sasha Neftin 2018-06-24  2506  			}
d32b0b48 Sasha Neftin 2018-06-24  2507  
d32b0b48 Sasha Neftin 2018-06-24  2508  		/* also check for alternate media here */
d32b0b48 Sasha Neftin 2018-06-24  2509  		} else if (!netif_carrier_ok(netdev) &&
d32b0b48 Sasha Neftin 2018-06-24  2510  			   (adapter->flags & IGC_FLAG_MAS_ENABLE)) {
d32b0b48 Sasha Neftin 2018-06-24  2511  			igc_check_swap_media(adapter);
d32b0b48 Sasha Neftin 2018-06-24  2512  			if (adapter->flags & IGC_FLAG_MEDIA_RESET) {
d32b0b48 Sasha Neftin 2018-06-24  2513  				schedule_work(&adapter->reset_task);
d32b0b48 Sasha Neftin 2018-06-24  2514  				/* return immediately */
d32b0b48 Sasha Neftin 2018-06-24  2515  				return;
d32b0b48 Sasha Neftin 2018-06-24  2516  			}
d32b0b48 Sasha Neftin 2018-06-24  2517  		}
d32b0b48 Sasha Neftin 2018-06-24  2518  	}
d32b0b48 Sasha Neftin 2018-06-24  2519  
d32b0b48 Sasha Neftin 2018-06-24  2520  	spin_lock(&adapter->stats64_lock);
d32b0b48 Sasha Neftin 2018-06-24  2521  	igc_update_stats(adapter);
d32b0b48 Sasha Neftin 2018-06-24  2522  	spin_unlock(&adapter->stats64_lock);
d32b0b48 Sasha Neftin 2018-06-24  2523  
d32b0b48 Sasha Neftin 2018-06-24  2524  	for (i = 0; i < adapter->num_tx_queues; i++) {
d32b0b48 Sasha Neftin 2018-06-24  2525  		struct igc_ring *tx_ring = adapter->tx_ring[i];
d32b0b48 Sasha Neftin 2018-06-24  2526  
d32b0b48 Sasha Neftin 2018-06-24  2527  		if (!netif_carrier_ok(netdev)) {
d32b0b48 Sasha Neftin 2018-06-24  2528  			/* We've lost link, so the controller stops DMA,
d32b0b48 Sasha Neftin 2018-06-24  2529  			 * but we've got queued Tx work that's never going
d32b0b48 Sasha Neftin 2018-06-24  2530  			 * to get done, so reset controller to flush Tx.
d32b0b48 Sasha Neftin 2018-06-24  2531  			 * (Do the reset outside of interrupt context).
d32b0b48 Sasha Neftin 2018-06-24  2532  			 */
d32b0b48 Sasha Neftin 2018-06-24  2533  			if (igc_desc_unused(tx_ring) + 1 < tx_ring->count) {
d32b0b48 Sasha Neftin 2018-06-24  2534  				adapter->tx_timeout_count++;
d32b0b48 Sasha Neftin 2018-06-24  2535  				schedule_work(&adapter->reset_task);
d32b0b48 Sasha Neftin 2018-06-24  2536  				/* return immediately since reset is imminent */
d32b0b48 Sasha Neftin 2018-06-24  2537  				return;
d32b0b48 Sasha Neftin 2018-06-24  2538  			}
d32b0b48 Sasha Neftin 2018-06-24  2539  		}
d32b0b48 Sasha Neftin 2018-06-24  2540  
d32b0b48 Sasha Neftin 2018-06-24  2541  		/* Force detection of hung controller every watchdog period */
d32b0b48 Sasha Neftin 2018-06-24  2542  		set_bit(IGC_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags);
d32b0b48 Sasha Neftin 2018-06-24  2543  	}
d32b0b48 Sasha Neftin 2018-06-24  2544  
d32b0b48 Sasha Neftin 2018-06-24  2545  	/* Cause software interrupt to ensure Rx ring is cleaned */
d32b0b48 Sasha Neftin 2018-06-24  2546  	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
d32b0b48 Sasha Neftin 2018-06-24  2547  		u32 eics = 0;
d32b0b48 Sasha Neftin 2018-06-24  2548  
d32b0b48 Sasha Neftin 2018-06-24  2549  		for (i = 0; i < adapter->num_q_vectors; i++)
d32b0b48 Sasha Neftin 2018-06-24  2550  			eics |= adapter->q_vector[i]->eims_value;
d32b0b48 Sasha Neftin 2018-06-24  2551  		wr32(E1000_EICS, eics);
d32b0b48 Sasha Neftin 2018-06-24  2552  	} else {
d32b0b48 Sasha Neftin 2018-06-24  2553  		wr32(E1000_ICS, E1000_ICS_RXDMT0);
d32b0b48 Sasha Neftin 2018-06-24  2554  	}
d32b0b48 Sasha Neftin 2018-06-24  2555  
d32b0b48 Sasha Neftin 2018-06-24  2556  	/* Reset the timer */
d32b0b48 Sasha Neftin 2018-06-24  2557  	if (!test_bit(__IGC_DOWN, &adapter->state)) {
d32b0b48 Sasha Neftin 2018-06-24  2558  		if (adapter->flags & IGC_FLAG_NEED_LINK_UPDATE)
d32b0b48 Sasha Neftin 2018-06-24  2559  			mod_timer(&adapter->watchdog_timer,
d32b0b48 Sasha Neftin 2018-06-24  2560  				  round_jiffies(jiffies +  HZ));
d32b0b48 Sasha Neftin 2018-06-24  2561  		else
d32b0b48 Sasha Neftin 2018-06-24  2562  			mod_timer(&adapter->watchdog_timer,
d32b0b48 Sasha Neftin 2018-06-24  2563  				  round_jiffies(jiffies + 2 * HZ));
d32b0b48 Sasha Neftin 2018-06-24  2564  	}
d32b0b48 Sasha Neftin 2018-06-24  2565  }
d32b0b48 Sasha Neftin 2018-06-24  2566  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
