From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Tue, 23 Oct 2018 13:31:59 +0200
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: allow non-monotonic
 SYSTIM readings
In-Reply-To: <02874ECE860811409154E81DA85FBB5884CDDA0E@ORSMSX115.amr.corp.intel.com>
References: <20181017161621.6081-1-mlichvar@redhat.com>
 <02874ECE860811409154E81DA85FBB5884CDDA0E@ORSMSX115.amr.corp.intel.com>
Message-ID: <20181023113159.GR4407@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 19, 2018 at 04:56:02PM +0000, Keller, Jacob E wrote:
> > @@ -233,6 +237,9 @@ static void e1000e_systim_overflow_work(struct
> > work_struct *work)
> >  	struct e1000_hw *hw = &adapter->hw;
> >  	struct timespec64 ts;
> > 
> > +	/* Update the timecounter */
> > +	timecounter_read(&adapter->tc);
> > +
> 
> yea, we previously depended on the gettime64 to do timecounter_read implicitly.
> 
> >  	adapter->ptp_clock_info.gettime64(&adapter->ptp_clock_info, &ts);
> 
> Can't we drop this line now?

Yes. We can save the value returned by the timecounter_read call and
convert it to timespec for the debug message below. I'll send a new
patch.

> > 
> >  	e_dbg("SYSTIM overflow check at %lld.%09lu\n",

Thanks,

-- 
Miroslav Lichvar
