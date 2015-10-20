From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 20 Oct 2015 12:48:03 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH v4 1/4] Produce system time from
	correlated clocksource
In-Reply-To: <20151020085408.GA2542@netboy>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1510132116480.25029@nanos>
 <op.x6iyd7gq1774gr@chall-mobl2.amr.corp.intel.com>
 <alpine.DEB.2.11.1510151014330.3960@nanos>
 <op.x6r25dza1774gr@chall-mobl2.amr.corp.intel.com>
 <CALAqxLXu_C8sWaKyxqXJPFV+m5Zdk=4q4s7O6NoLR1B8bbyuxg@mail.gmail.com>
 <20151020085408.GA2542@netboy>
Message-ID: <alpine.DEB.2.11.1510201246250.3982@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 20 Oct 2015, Richard Cochran wrote:

> On Mon, Oct 19, 2015 at 05:36:56PM -0700, John Stultz wrote:
> > If we're only tracking 4ms of history, how does this solution
> > measurably improve the error over using the timestamps to generate
> > MONOTONIC_RAW clock deltas (which doesn't require keeping any history)
> > and using getnstime_raw_and_real to take an anchor point to calculate
> > the delta from?  Why is adding complexity necessary?
> 
> This idea is variant of what I suggested in another reply in this
> thread.  To my understanding, there is no need at all to keep a
> history arbitrarily 4 ms long.  Instead, the DSP driver (or whoever
> else may need such a thing) can simply sample the system time at the
> rate needed for that particular application.

That's complete nonsense. The whole point is to have a proper
correlation from ART/audio timestamps to system time. Sampling system
time does not help in any way,

Thanks,

	tglx
