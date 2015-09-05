From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 5 Sep 2015 10:46:51 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH v3 1/4] Add correlated clocksource
 deriving system time from an auxiliary clocksource
In-Reply-To: <B79D786B7111A34A8CF09F833429C493A90B2FDE@ORSMSX109.amr.corp.intel.com>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222143530.3873@nanos>
 <B79D786B7111A34A8CF09F833429C493A90B2D1F@ORSMSX109.amr.corp.intel.com>
 <alpine.DEB.2.11.1509041438520.15006@nanos>
 <20150904151021.GF18489@twins.programming.kicks-ass.net>
 <20150904151743.GB16862@localhost.localdomain>
 <20150904154133.GI18489@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1509041832440.15006@nanos>
 <B79D786B7111A34A8CF09F833429C493A90B2FDE@ORSMSX109.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.11.1509051044040.15006@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 4 Sep 2015, Hall, Christopher S wrote:
> > Right, but we still do not know how that is going to be used. And
> > that's the key question. As long as that is not answered all can do is
> > wild guessing.
> 
> It's not wild guessing.  We do have it working on other OSs and have
> a pretty good idea of how it will work.  The DSP firmware will be
> largely identical for Linux.  I think now, we have a chicken and egg
> problem.

You have a totally different problem. You are just refusing to explain
how all that stuff is supposed to work and what kind of functionality
you need exactly.

Is it that hard to describe the technical requirements and the
presumably assbackwards restrictions of the firmware?

Thanks,

	tglx




