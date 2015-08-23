From: Richard Cochran <richardcochran@gmail.com>
Date: Sun, 23 Aug 2015 13:25:56 +0200
Subject: [Intel-wired-lan] [PATCH v3 3/4] Add support for driver
 cross-timestamp to PTP_SYS_OFFSET ioctl
In-Reply-To: <alpine.DEB.2.11.1508231011360.3873@nanos>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-4-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222226540.3873@nanos>
 <20150822211718.GA8561@netboy>
 <alpine.DEB.2.11.1508231011360.3873@nanos>
Message-ID: <20150823112556.GA8569@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Aug 23, 2015 at 10:15:00AM +0200, Thomas Gleixner wrote:
> So why can't you take N samples from the synced hardware? It does not
> make any sense to me to switch to the imprecise mode if nsamples > 1.

Ok, then I prefer to leave this "imprecise" method in place and ...
 
> You can also provide a new IOCTL PTP_SYS_OFFSET_PRECISE which returns
> -ENOSYS if hardware timestamping is not available and avoid the whole
> nsamples dance for the case where we can get precise timestamps.

have this for the new way.

By keeping the imprecise method, we will be able to run both methods
on the new hardware.  That will help to quantify how imprecise the old
method is.

Thanks,
Richard

