From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 6 Dec 2016 22:51:17 +0000
Subject: [Intel-wired-lan] [PATCH] [PATCH v2] igb:
	close/suspend	race	in	netif_device_detach
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81FE72A4@ORSMSX101.amr.corp.intel.com>
References: <1479228866-15506-1-git-send-email-todd.fujinaka@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81FE2C9A@ORSMSX101.amr.corp.intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81FE72A4@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81FE7313@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Brown, Aaron F
> Sent: Tuesday, December 6, 2016 2:14 PM
> To: Fujinaka, Todd <todd.fujinaka@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] [PATCH v2] igb: close/suspend race in
> netif_device_detach
> 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> > Behalf Of Brown, Aaron F
> > Sent: Wednesday, November 30, 2016 12:26 PM
> > To: Fujinaka, Todd <todd.fujinaka@intel.com>; intel-wired-
> > lan at lists.osuosl.org
> > Subject: Re: [Intel-wired-lan] [PATCH] [PATCH v2] igb: close/suspend race in
> > netif_device_detach
> >
> > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> On
> > > Behalf Of Todd Fujinaka
> > > Sent: Tuesday, November 15, 2016 8:54 AM
> > > To: intel-wired-lan at lists.osuosl.org
> > > Subject: [Intel-wired-lan] [PATCH] [PATCH v2] igb: close/suspend race in
> > > netif_device_detach
> > >
> > > Similar to ixgbe, when an interface is part of a namespace it is
> > > possible that igb_close() may be called while __igb_shutdown() is
> > > running which ends up in a double free WARN and/or a BUG in
> > > free_msi_irqs().
> > >
> > > Extend the rtnl_lock() to protect the call to netif_device_detach() and
> > > igb_clear_interrupt_scheme() in __igb_shutdown() and check for
> > > netif_device_present() to avoid calling igb_clear_interrupt_scheme() a
> > > second time in igb_close().
> > >
> > > Also extend the rtnl lock in igb_resume() to netif_device_attach().
> > >
> > > Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/igb/igb_main.c | 21 ++++++++++++---------
> > >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > Tested-by Aaron Brown <aaron.f.brown@intel.com>
> 
> Patchwork did not pick this Tested-by, probably because I left out the colon.
> Try again...
> Tested-by: Aaron Brown <aaron.f.brown at intel.com<
D'OH!

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
