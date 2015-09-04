From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 4 Sep 2015 17:17:43 +0200
Subject: [Intel-wired-lan] [PATCH v3 1/4] Add correlated clocksource
 deriving system time from an auxiliary clocksource
In-Reply-To: <20150904151021.GF18489@twins.programming.kicks-ass.net>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222143530.3873@nanos>
 <B79D786B7111A34A8CF09F833429C493A90B2D1F@ORSMSX109.amr.corp.intel.com>
 <alpine.DEB.2.11.1509041438520.15006@nanos>
 <20150904151021.GF18489@twins.programming.kicks-ass.net>
Message-ID: <20150904151743.GB16862@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 04, 2015 at 05:10:21PM +0200, Peter Zijlstra wrote:
> I think what they're getting at is asking if there's a rate limit to
> time adjustments, without that, saving the last n transition points will
> still not cover any given length of history.

As if the ntp code isn't complex enough already - now we're adding
sample histories and adjustment rating limiting?

And all for some unknown DSP in a mythical sound card??


Thanks,
Richard



