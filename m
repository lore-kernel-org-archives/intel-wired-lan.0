From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 15 Oct 2015 10:13:36 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH v4 1/4] Produce system time from
	correlated clocksource
In-Reply-To: <20151015054142.GA4784@netboy>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-2-git-send-email-christopher.s.hall@intel.com>
 <20151013045832.GA2437@netboy> <alpine.DEB.2.11.1510130944520.6097@nanos>
 <20151013083113.GA1931@localhost.localdomain>
 <alpine.DEB.2.11.1510132113470.25029@nanos> <20151013211224.GA19242@netboy>
 <op.x6iz21fw1774gr@chall-mobl2.amr.corp.intel.com>
 <20151015054142.GA4784@netboy>
Message-ID: <alpine.DEB.2.11.1510151007070.3960@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 15 Oct 2015, Richard Cochran wrote:
> Thomas seems to say that there are *other* applications that will want
> to transform device time into system time, but why does your audio
> application use the system time, when the audio-to-ptp time is
> directly available, without any man in the middle?

PTP time is slow to access. Having a correlation to system time makes
a log of things simpler; nanosleep is the most obvious example.

Thanks,

	tglx
