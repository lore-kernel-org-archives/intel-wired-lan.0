From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 4 Sep 2015 10:11:22 +0200
Subject: [Intel-wired-lan] [PATCH v3 1/4] Add correlated clocksource
 deriving system time from an auxiliary clocksource
In-Reply-To: <B79D786B7111A34A8CF09F833429C493A90B2D1F@ORSMSX109.amr.corp.intel.com>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222143530.3873@nanos>
 <B79D786B7111A34A8CF09F833429C493A90B2D1F@ORSMSX109.amr.corp.intel.com>
Message-ID: <20150904081122.GA4201@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 03, 2015 at 11:20:37PM +0000, Hall, Christopher S wrote:
> In addition to the network interface, ART will be used in the audio interface as well.
> We need to support the case where an audio co-processor will control the audio device.
> In this case, the get_ts() function supplied by the audio driver will be very slow
> (several milliseconds) and the result will be out of date by some fraction of that 
> amount.

Why does it take milliseconds to read one audio time stamp?

Thanks,
Richard
