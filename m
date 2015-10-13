From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 13 Oct 2015 23:12:24 +0200
Subject: [Intel-wired-lan] [PATCH v4 1/4] Produce system time from
	correlated clocksource
In-Reply-To: <alpine.DEB.2.11.1510132113470.25029@nanos>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-2-git-send-email-christopher.s.hall@intel.com>
 <20151013045832.GA2437@netboy>
 <alpine.DEB.2.11.1510130944520.6097@nanos>
 <20151013083113.GA1931@localhost.localdomain>
 <alpine.DEB.2.11.1510132113470.25029@nanos>
Message-ID: <20151013211224.GA19242@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 13, 2015 at 09:15:51PM +0200, Thomas Gleixner wrote:
> That's not working. The firmware is not going to change, no matter
> what.

Can we at least have a explanation of how the firmware operates?  How
are (ART,sys) pairs are generated, and how they are supposed to get
into the DSP?

Thanks,
Richard



