From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 26 Oct 2018 15:47:49 +0000
Subject: [Intel-wired-lan] [PATCH] igb: shorten maximum PHC timecounter
 update interval
In-Reply-To: <20181026120416.GB27139@localhost>
References: <20181012111339.1361-1-mlichvar@redhat.com>
 <20181012140530.6mjxkb2co3nhl5pf@localhost>
 <20181026120416.GB27139@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB5884CE49B5@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Friday, October 26, 2018 5:04 AM
> To: Richard Cochran <richardcochran@gmail.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; Thomas Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH] igb: shorten maximum PHC timecounter update interval
> 
> On Fri, Oct 12, 2018 at 07:05:30AM -0700, Richard Cochran wrote:
> > On Fri, Oct 12, 2018 at 01:13:39PM +0200, Miroslav Lichvar wrote:
> > > Since commit 500462a9d ("timers: Switch to a non-cascading wheel"),
> > > scheduling of delayed work seems to be less accurate and a requested
> > > delay of 540 seconds may actually be longer than 550 seconds. Shorten
> > > the delay to 480 seconds to be sure the timecounter is updated in time.
> >
> > Good catch.  This timer wheel change will affect other, similar
> > drivers.  Guess I'll go through and adjust their timeouts, too.
> 
> I just realized that we need to fit there also any frequency
> adjustments of the PHC and system clock. The PHC can be set to run up
> to 6% faster and the system clock can be slowed down by up to 10%.
> 
> Those 480 seconds in the igb driver is not short enough for that.
> Should I fix and resend this patch, or send a new one?
> 
> Other drivers may have a similar problem.
> 

Hmm, good point. I'd send a v2 of this patch, unless it's already been applied to net or net-next.

Thanks,
Jake

> --
> Miroslav Lichvar
