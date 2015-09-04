From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 4 Sep 2015 17:10:21 +0200
Subject: [Intel-wired-lan] [PATCH v3 1/4] Add correlated clocksource
 deriving system time from an auxiliary clocksource
In-Reply-To: <alpine.DEB.2.11.1509041438520.15006@nanos>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222143530.3873@nanos>
 <B79D786B7111A34A8CF09F833429C493A90B2D1F@ORSMSX109.amr.corp.intel.com>
 <alpine.DEB.2.11.1509041438520.15006@nanos>
Message-ID: <20150904151021.GF18489@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 04, 2015 at 03:02:19PM +0200, Thomas Gleixner wrote:
> > For example, supply the ART value as an argument and, in the case of
> > the realtime clock, keep a short history of clock changes.  It would
> 
> It's not only clock realtime which is affected by those.
> 
> > fail in cases where there are a lot of calls to adjtimex(),
> 
> That has nothing to do with lots of adjtimex calls. The kernel does a
> slow correction of the conversion values itself to avoid time jumping
> around.

I think what they're getting at is asking if there's a rate limit to
time adjustments, without that, saving the last n transition points will
still not cover any given length of history.

So what I think they're looking for; is given an upper bound on the DSP
delaying its data, come up with a fixed minimal amount of transitions
points we must store to cover the history.


