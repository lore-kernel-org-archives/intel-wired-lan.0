From: David Z. Dai <zdai@linux.vnet.ibm.com>
Date: Mon, 07 Oct 2019 10:50:59 -0500
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Use rtnl_lock to prevent
 race conditions between net and pci/pm
In-Reply-To: <CAKgT0Ud7SupVd3RQmTEJ8e0fixiptS-1wFg+8V4EqpHEuAC3wQ@mail.gmail.com>
References: <1570208647.1250.55.camel@oc5348122405>
 <20191004233052.28865.1609.stgit@localhost.localdomain>
 <1570241926.10511.7.camel@oc5348122405>
 <CAKgT0Ud7SupVd3RQmTEJ8e0fixiptS-1wFg+8V4EqpHEuAC3wQ@mail.gmail.com>
Message-ID: <1570463459.1510.5.camel@oc5348122405>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2019-10-05 at 10:22 -0700, Alexander Duyck wrote:
> On Fri, Oct 4, 2019 at 7:18 PM David Z. Dai <zdai@linux.vnet.ibm.com> wrote:
> >
> > On Fri, 2019-10-04 at 16:36 -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > >
> > > This patch is meant to address possible race conditions that can exist
> > > between network configuration and power management. A similar issue was
> > > fixed for igb in commit 9474933caf21 ("igb: close/suspend race in
> > > netif_device_detach").
> > >
> > > In addition it consolidates the code so that the PCI error handling code
> > > will essentially perform the power management freeze on the device prior to
> > > attempting a reset, and will thaw the device afterwards if that is what it
> > > is planning to do. Otherwise when we call close on the interface it should
> > > see it is detached and not attempt to call the logic to down the interface
> > > and free the IRQs again.
> > >
> > > >From what I can tell the check that was adding the check for __E1000_DOWN
> > > in e1000e_close was added when runtime power management was added. However
> > > it should not be relevant for us as we perform a call to
> > > pm_runtime_get_sync before we call e1000_down/free_irq so it should always
> > > be back up before we call into this anyway.
> > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > ---
> > >
> > > I'm putting this out as an RFC for now. I haven't had a chance to do much
> > > testing yet, but I have verified no build issues, and the driver appears
> > > to load, link, and pass traffic without problems.
> > >
> > > This should address issues seen with either double freeing or never freeing
> > > IRQs that have been seen on this and similar drivers in the past.
> > >
> > > I'll submit this formally after testing it over the weekend assuming there
> > > are no issues.
> > >
> > >  drivers/net/ethernet/intel/e1000e/netdev.c |   33 ++++++++++++++--------------
> > >  1 file changed, 17 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> > > index d7d56e42a6aa..182a2c8f12d8 100644
> > > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> 
> <snip>
> 
> > >
> > > -#ifdef CONFIG_PM_SLEEP
> > >  static int e1000e_pm_thaw(struct device *dev)
> > >  {
> > >       struct net_device *netdev = dev_get_drvdata(dev);
> > >       struct e1000_adapter *adapter = netdev_priv(netdev);
> > > +     int rc = 0;
> > >
> > >       e1000e_set_interrupt_capability(adapter);
> > > -     if (netif_running(netdev)) {
> > > -             u32 err = e1000_request_irq(adapter);
> > >
> > > -             if (err)
> > > -                     return err;
> > > +     rtnl_lock();
> > > +     if (netif_running(netdev)) {
> > > +             rc = e1000_request_irq(adapter);
> > > +             if (rc)
> > > +                     goto err_irq;
> > >
> > >               e1000e_up(adapter);
> > >       }
> > >
> > >       netif_device_attach(netdev);
> > > -
> > > -     return 0;
> > > +     rtnl_unlock();
> > > +err_irq:
> > > +     return rc;
> > >  }
> > >
> > In e1000e_pm_thaw(), these 2 lines need to switch order to avoid
> > deadlock.
> > from:
> > +       rtnl_unlock();
> > +err_irq:
> >
> > to:
> > +err_irq:
> > +       rtnl_unlock();
> >
> > I will find hardware to test this patch next week. Will update the test
> > result later.
> >
> > Thanks! - David
> 
> Thanks for spotting that. I will update my copy of the patch for when
> I submit the final revision.
> 
> I'll probably wait to submit it for acceptance until you have had a
> chance to verify that it resolves the issue you were seeing.
> 
> Thanks.
> 
> - Alex
We have tested on one of the test box.
With this patch, it doesn't crash kernel anymore, which is good!

However we see this warning message from the log file for irq number 0:
[10206.317270] Trying to free already-free IRQ 0

With this stack:
[10206.317344] NIP [c00000000018cbf8] __free_irq+0x308/0x370
[10206.317346] LR [c00000000018cbf4] __free_irq+0x304/0x370
[10206.317347] Call Trace:
[10206.317348] [c00000008b92b970] [c00000000018cbf4] __free_irq
+0x304/0x370 (unreliable)
[10206.317351] [c00000008b92ba00] [c00000000018cd84] free_irq+0x84/0xf0
[10206.317358] [c00000008b92ba30] [d000000007449e60] e1000_free_irq
+0x98/0xc0 [e1000e]
[10206.317365] [c00000008b92ba60] [d000000007458a70] e1000e_pm_freeze
+0xb8/0x100 [e1000e]
[10206.317372] [c00000008b92baa0] [d000000007458b6c]
e1000_io_error_detected+0x34/0x70 [e1000e]
[10206.317375] [c00000008b92bad0] [c000000000040358] eeh_report_failure
+0xc8/0x190
[10206.317377] [c00000008b92bb20] [c00000000003eb2c] eeh_pe_dev_traverse
+0x9c/0x170
[10206.317379] [c00000008b92bbb0] [c000000000040d84]
eeh_handle_normal_event+0xe4/0x580
[10206.317382] [c00000008b92bc60] [c000000000041330] eeh_handle_event
+0x30/0x340
[10206.317384] [c00000008b92bd10] [c000000000041780] eeh_event_handler
+0x140/0x200
[10206.317386] [c00000008b92bdc0] [c0000000001397c8] kthread+0x1a8/0x1b0
[10206.317389] [c00000008b92be30] [c00000000000b560]
ret_from_kernel_thread+0x5c/0x7c

Thanks! - David

