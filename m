From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 31 Oct 2018 16:56:36 +0000
Subject: [Intel-wired-lan] [RFC PATCH 3/4] igb: add support for extended
 PHC gettime
In-Reply-To: <20181031093935.GL31668@localhost>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-4-mlichvar@redhat.com>
 <20181031022916.nuvbjegnn6bsqxss@localhost>
 <20181031093935.GL31668@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB5884D0FDF4@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Wednesday, October 31, 2018 2:40 AM
> To: Richard Cochran <richardcochran@gmail.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: Re: [RFC PATCH 3/4] igb: add support for extended PHC gettime
> 
> On Tue, Oct 30, 2018 at 07:29:16PM -0700, Richard Cochran wrote:
> > On Fri, Oct 26, 2018 at 06:27:41PM +0200, Miroslav Lichvar wrote:
> > > +static int igb_ptp_gettimex(struct ptp_clock_info *ptp,
> > > +			    struct ptp_system_timestamp *sts)
> > > +{
> > > +	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
> > > +					       ptp_caps);
> > > +	struct e1000_hw *hw = &igb->hw;
> > > +	unsigned long flags;
> > > +	u32 lo, hi;
> > > +	u64 ns;
> > > +
> > > +	spin_lock_irqsave(&igb->tmreg_lock, flags);
> > > +
> > > +	/* 82576 doesn't have SYSTIMR */
> > > +	if (igb->hw.mac.type == e1000_82576) {
> >
> > Instead of if/then/else, can't you follow the pattern of providing
> > different function flavors ...
> 
> I can. I was just trying to minimize the amount of triplicated code.
> In the next version I'll add a patch to deprecate the old gettime
> functions, as Jacob suggested, and replace them with the extended
> versions, so the amount of code will not change that much.
> 

Excellent.

-Jake

> Thanks,
> 
> --
> Miroslav Lichvar
