From: Nunley, Nicholas D <nicholas.d.nunley@intel.com>
Date: Mon, 15 Mar 2021 23:31:39 +0000
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix asynchronous tasks
 during driver remove
In-Reply-To: <20210312123615.7fcvoayobcslko74@p50.fritz.box>
References: <20210312093337.68364-1-eryk.roch.rybak@intel.com>
 <20210312123615.7fcvoayobcslko74@p50.fritz.box>
Message-ID: <DM5PR1101MB20742AB907C04D1B6A6C6A4FB36C9@DM5PR1101MB2074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks for pointing this out. This was an accidental oversight, although I think part of my reason for not paying close enough attention is that the client code is never actually used. Since there aren't any plans to use the client code in the future, we discussed this here and the plan is to remove that code from the iavf driver. We'll be submitting a patch for that soon, but in the meantime I think we'll be all right if this patch goes in as-is, since the bug is purely hypothetical and has no real-world impact.

Nick
> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Stefan Assmann
> Sent: Friday, March 12, 2021 4:36 AM
> To: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net v2] iavf: Fix asynchronous tasks
> during driver remove
> 
> On 2021-03-12 10:33, Eryk Rybak wrote:
> > Although rare, is possible for unexpected driver watchdog or Admin
> > Queue tasks to run during the execution of iavf_remove function.
> > Then, is not possible to obtain the standard __IAVF_IN_CRITICAL_TASK
> > lock and difficult to ensure that the driver state stays consistent
> > during the full removal process.
> 
> If you shutdown the watchdog task before closing the device, how do you
> ensure the client task is properly shutdown?
> 
> Calling iavf_close() sets the IAVF_FLAG_CLIENT_NEEDS_CLOSE flag, which
> would call iavf_notify_client_close(&adapter->vsi, false); in the client task,
> but the client task does no longer get scheduled by the watchdog task
> because it has been shutdown already.
> 
>   Stefan
> 
> > Fully stops all asynchronous tasks in the beginning of iavf_remove,
> > and uses a single-threaded flow to shut down the driver.
> >
> > Fixes: fdd4044ffdc8("iavf: Remove timer for work triggering, use
> > delaying work instead")
> > Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_main.c | 31
> > +++++++++++++++++----
> >  1 file changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index dc5b3c06d1e0..e752ecb7ad89 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -1887,6 +1887,12 @@ static void iavf_watchdog_task(struct
> work_struct *work)
> >  	struct iavf_hw *hw = &adapter->hw;
> >  	u32 reg_val;
> >
> > +	/* If the driver is in the process of being removed then don't run or
> > +	 * reschedule the watchdog task.
> > +	 */
> > +	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
> > +		return;
> > +
> >  	if (test_and_set_bit(__IAVF_IN_CRITICAL_TASK, &adapter-
> >crit_section))
> >  		goto restart_watchdog;
> >
> > @@ -2267,6 +2273,12 @@ static void iavf_adminq_task(struct work_struct
> *work)
> >  	u32 val, oldval;
> >  	u16 pending;
> >
> > +	/* If the driver is in the process of being removed then return
> > +	 * immediately and don't re-enable the Admin Queue interrupt.
> > +	 */
> > +	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
> > +		return;
> > +
> >  	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
> >  		goto out;
> >
> > @@ -3245,6 +3257,13 @@ static int iavf_close(struct net_device
> > *netdev)
> >
> >  	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
> >
> > +	/* If the interface is closing as part of driver removal it doesn't
> > +	 * wait. The VF resources will be reinitialized when the hardware is
> > +	 * reset.
> > +	 */
> > +	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
> > +		return 0;
> > +
> >  	/* We explicitly don't free resources here because the hardware is
> >  	 * still active and can DMA into memory. Resources are cleared in
> >  	 * iavf_virtchnl_completion() after we get confirmation from the PF
> > @@ -3850,11 +3869,16 @@ static void iavf_remove(struct pci_dev *pdev)
> >  	struct iavf_cloud_filter *cf, *cftmp;
> >  	struct iavf_hw *hw = &adapter->hw;
> >  	int err;
> > -	/* Indicate we are in remove and not to run reset_task */
> > +	/* Indicate that program driver is remove task and not
> > +	 * to run/schedule any driver tasks
> > +	 */
> >  	set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section);
> >  	cancel_delayed_work_sync(&adapter->init_task);
> >  	cancel_work_sync(&adapter->reset_task);
> >  	cancel_delayed_work_sync(&adapter->client_task);
> > +	cancel_work_sync(&adapter->adminq_task);
> > +	cancel_delayed_work_sync(&adapter->watchdog_task);
> > +	iavf_misc_irq_disable(adapter);
> >  	if (adapter->netdev_registered) {
> >  		unregister_netdev(netdev);
> >  		adapter->netdev_registered = false; @@ -3879,15 +3903,10
> @@ static
> > void iavf_remove(struct pci_dev *pdev)
> >  	}
> >  	iavf_free_all_tx_resources(adapter);
> >  	iavf_free_all_rx_resources(adapter);
> > -	iavf_misc_irq_disable(adapter);
> >  	iavf_free_misc_irq(adapter);
> >  	iavf_reset_interrupt_capability(adapter);
> >  	iavf_free_q_vectors(adapter);
> >
> > -	cancel_delayed_work_sync(&adapter->watchdog_task);
> > -
> > -	cancel_work_sync(&adapter->adminq_task);
> > -
> >  	iavf_free_rss(adapter);
> >
> >  	if (hw->aq.asq.count)
> >
> > base-commit: c1acda9807e2bbe1d2026b44f37d959d6d8266c8
> > --
> > 2.20.1
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> >
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
