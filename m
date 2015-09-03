From: Hall, Christopher S <christopher.s.hall@intel.com>
Date: Thu, 3 Sep 2015 23:20:37 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/4] Add correlated clocksource
 deriving system time from an auxiliary clocksource
In-Reply-To: <alpine.DEB.2.11.1508222143530.3873@nanos>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222143530.3873@nanos>
Message-ID: <B79D786B7111A34A8CF09F833429C493A90B2D1F@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Saturday, August 22, 2015 1:17 PM
> To: Hall, Christopher S
> Cc: Kirsher, Jeffrey T; hpa at zytor.com; mingo at redhat.com;
> john.stultz at linaro.org; richardcochran at gmail.com; x86 at kernel.org; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; peterz at infradead.org
> Subject: Re: [PATCH v3 1/4] Add correlated clocksource deriving system time
> from an auxiliary clocksource
>  
> > +/**
> > + * get_correlated_timestamp - Get a correlated timestamp
> > + *
> > + * Reads a timestamp from a device and correlates it to system time
> > + */
> > +int get_correlated_timestamp(struct correlated_ts *crt,
> > +			     struct correlated_cs *crs)
> > +{
> > +	struct timekeeper *tk = &tk_core.timekeeper;
> > +	unsigned long seq;
> > +	cycles_t cycles;
> > +	ktime_t base;
> > +	s64 nsecs;
> > +	int ret;
> > +
> > +	do {
> > +		seq = read_seqcount_begin(&tk_core.seq);
> > +		/*
> > +		 * Verify that the correlated clocksoure is related to
> > +		 * the currently installed timekeeper clocksoure
> > +		 */
> > +		if (tk->tkr_mono.clock != crs->related_cs)
> > +			return -ENODEV;
> > +
> > +		/*
> > +		 * Try to get a timestamp from the device.
> > +		 */
> > +		ret = crt->get_ts(crt);
> > +		if (ret)
> > +			return ret;
> > +
[Re-added code for context]

In addition to the network interface, ART will be used in the audio interface as well.
We need to support the case where an audio co-processor will control the audio device.
In this case, the get_ts() function supplied by the audio driver will be very slow
(several milliseconds) and the result will be out of date by some fraction of that 
amount.

This loop makes strict requirements on the latency and recency. Is it possible to relax
that requirement in some way?

For example, supply the ART value as an argument and, in the case of the realtime
clock, keep a short history of clock changes.  It would fail in cases where there
are a lot of calls to adjtimex(), but it will would work most of the time.

What can you suggest? Thanks

Chris

> > +	} while (read_seqcount_retry(&tk_core.seq, seq));
> > +	return 0;
> > +}


