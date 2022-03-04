From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 4 Mar 2022 10:04:38 -0800
Subject: [Intel-wired-lan] [bug report] iavf: Fix deadlock in
 iavf_reset_task
In-Reply-To: <20220304115300.GA7106@kili>
References: <20220304115300.GA7106@kili>
Message-ID: <bf961bc6-2b06-f68b-3d0b-e4a388c7d8ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Dan,

On 3/4/2022 3:53 AM, Dan Carpenter wrote:
> Hello Slawomir Laba,
>
> The patch e85ff9c631e1: "iavf: Fix deadlock in iavf_reset_task" from
> Feb 23, 2022, leads to the following Smatch static checker warning:
>
> 	drivers/net/ethernet/intel/iavf/iavf_main.c:2691 iavf_reset_task()
> 	error: double unlocked '&adapter->crit_lock' (orig line 2689)
>
> drivers/net/ethernet/intel/iavf/iavf_main.c
>      2613 static void iavf_reset_task(struct work_struct *work)
>      2614 {
>      2615         struct iavf_adapter *adapter = container_of(work,
>      2616                                                       struct iavf_adapter,
>      2617                                                       reset_task);
>      2618         struct virtchnl_vf_resource *vfres = adapter->vf_res;
>      2619         struct net_device *netdev = adapter->netdev;
>      2620         struct iavf_hw *hw = &adapter->hw;
>      2621         struct iavf_mac_filter *f, *ftmp;
>      2622         struct iavf_cloud_filter *cf;
>      2623         u32 reg_val;
>      2624         int i = 0, err;
>      2625         bool running;
>      2626
>      2627         /* When device is being removed it doesn't make sense to run the reset
>      2628          * task, just return in such a case.
>      2629          */
>      2630         if (!mutex_trylock(&adapter->crit_lock)) {
>      2631                 if (adapter->state != __IAVF_REMOVE)
>      2632                         queue_work(iavf_wq, &adapter->reset_task);
>      2633
>      2634                 return;
>      2635         }
>      2636
>      2637         while (!mutex_trylock(&adapter->client_lock))
>      2638                 usleep_range(500, 1000);
>      2639         if (CLIENT_ENABLED(adapter)) {
>      2640                 adapter->flags &= ~(IAVF_FLAG_CLIENT_NEEDS_OPEN |
>      2641                                     IAVF_FLAG_CLIENT_NEEDS_CLOSE |
>      2642                                     IAVF_FLAG_CLIENT_NEEDS_L2_PARAMS |
>      2643                                     IAVF_FLAG_SERVICE_CLIENT_REQUESTED);
>      2644                 cancel_delayed_work_sync(&adapter->client_task);
>      2645                 iavf_notify_client_close(&adapter->vsi, true);
>      2646         }
>      2647         iavf_misc_irq_disable(adapter);
>      2648         if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
>      2649                 adapter->flags &= ~IAVF_FLAG_RESET_NEEDED;
>      2650                 /* Restart the AQ here. If we have been reset but didn't
>      2651                  * detect it, or if the PF had to reinit, our AQ will be hosed.
>      2652                  */
>      2653                 iavf_shutdown_adminq(hw);
>      2654                 iavf_init_adminq(hw);
>      2655                 iavf_request_reset(adapter);
>      2656         }
>      2657         adapter->flags |= IAVF_FLAG_RESET_PENDING;
>      2658
>      2659         /* poll until we see the reset actually happen */
>      2660         for (i = 0; i < IAVF_RESET_WAIT_DETECTED_COUNT; i++) {
>      2661                 reg_val = rd32(hw, IAVF_VF_ARQLEN1) &
>      2662                           IAVF_VF_ARQLEN1_ARQENABLE_MASK;
>      2663                 if (!reg_val)
>      2664                         break;
>      2665                 usleep_range(5000, 10000);
>      2666         }
>      2667         if (i == IAVF_RESET_WAIT_DETECTED_COUNT) {
>      2668                 dev_info(&adapter->pdev->dev, "Never saw reset\n");
>      2669                 goto continue_reset; /* act like the reset happened */
>      2670         }
>      2671
>      2672         /* wait until the reset is complete and the PF is responding to us */
>      2673         for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
>      2674                 /* sleep first to make sure a minimum wait time is met */
>      2675                 msleep(IAVF_RESET_WAIT_MS);
>      2676
>      2677                 reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
>      2678                           IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
>      2679                 if (reg_val == VIRTCHNL_VFR_VFACTIVE)
>      2680                         break;
>      2681         }
>      2682
>      2683         pci_set_master(adapter->pdev);
>      2684         pci_restore_msi_state(adapter->pdev);
>      2685
>      2686         if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
>      2687                 dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
>      2688                         reg_val);
>      2689                 iavf_disable_vf(adapter);
>
> The proble is that iavf_disable_vf() calls mutex_unlock(&adapter->crit_lock);
>
>      2690                 mutex_unlock(&adapter->client_lock);
> --> 2691                 mutex_unlock(&adapter->crit_lock);
>
> so calling it again here is a bug.
>
> I feel like I owe you an apology on this one because I asked you to add
> the mutex_unlock() here via the kbuild-bot...  It is confusing though.
> Does the unlock really need to be done inside iavf_disable_vf() are
> can we move that to the callers?

Thanks for the report. I talked to Slawomir about this and he is working 
up a patch to fix this.

-Tony


>
>      2692                 return; /* Do not attempt to reinit. It's dead, Jim. */
>      2693         }
>      2694
>      2695 continue_reset:
>      2696         /* We don't use netif_running() because it may be true prior to
>      2697          * ndo_open() returning, so we can't assume it means all our open
>      2698          * tasks have finished, since we're not holding the rtnl_lock here.
>      2699          */
>
> regards,
> dan carpenter
