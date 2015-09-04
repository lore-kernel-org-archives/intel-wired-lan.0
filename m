From: Hall, Christopher S <christopher.s.hall@intel.com>
Date: Fri, 4 Sep 2015 21:01:05 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/4] Add correlated clocksource
 deriving system time from an auxiliary clocksource
In-Reply-To: <alpine.DEB.2.11.1509041832440.15006@nanos>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222143530.3873@nanos>
 <B79D786B7111A34A8CF09F833429C493A90B2D1F@ORSMSX109.amr.corp.intel.com>
 <alpine.DEB.2.11.1509041438520.15006@nanos>
 <20150904151021.GF18489@twins.programming.kicks-ass.net>
 <20150904151743.GB16862@localhost.localdomain>
 <20150904154133.GI18489@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1509041832440.15006@nanos>
Message-ID: <B79D786B7111A34A8CF09F833429C493A90B2FDE@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Friday, September 04, 2015 9:35 AM
> To: Peter Zijlstra
> Cc: Richard Cochran; Hall, Christopher S; Kirsher, Jeffrey T;
> hpa at zytor.com; mingo at redhat.com; john.stultz at linaro.org; x86 at kernel.org;
> linux-kernel at vger.kernel.org; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [PATCH v3 1/4] Add correlated clocksource deriving system time
> from an auxiliary clocksource
> 
> On Fri, 4 Sep 2015, Peter Zijlstra wrote:
> > On Fri, Sep 04, 2015 at 05:17:43PM +0200, Richard Cochran wrote:
> > > On Fri, Sep 04, 2015 at 05:10:21PM +0200, Peter Zijlstra wrote:
> > > > I think what they're getting at is asking if there's a rate limit to
> > > > time adjustments, without that, saving the last n transition points
> will
> > > > still not cover any given length of history.
> > >
> > > As if the ntp code isn't complex enough already - now we're adding
> > > sample histories and adjustment rating limiting?
> > >
> > > And all for some unknown DSP in a mythical sound card??
> >
> > Hehe, I'm just a 'translator' here. But going by you answer I'm taking
> > it there isn't in fact a rate-limit to adjustments. Which, even if you
> > were not opposed to that direction, makes it an unfeasible proposition.
> >
> > Also, I'm not thinking its too mythical, sound/soc/intel/ is full of
> > audio DSP stuff, I think a newer version will just gain ART support.
> 
> Right, but we still do not know how that is going to be used. And
> that's the key question. As long as that is not answered all can do is
> wild guessing.

It's not wild guessing.  We do have it working on other OSs and have a pretty good 
idea of how it will work.  The DSP firmware will be largely identical for Linux.  I 
think now, we have a chicken and egg problem.

We can't post audio drivers that break, or are broken by, the current ART interface.  
How do I move this forward?  Should I minimally (I don't know exactly what that means 
just yet) rewrite the ART interface so that the audio driver is mostly not broken and 
post that along with the audio driver code?  Is this an acceptable approach?

> 
> Thanks,
> 
> 	tglx
