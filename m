From: Richard Cochran <richardcochran@gmail.com>
Date: Sat, 22 Aug 2015 23:17:18 +0200
Subject: [Intel-wired-lan] [PATCH v3 3/4] Add support for driver
 cross-timestamp to PTP_SYS_OFFSET ioctl
In-Reply-To: <alpine.DEB.2.11.1508222226540.3873@nanos>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-4-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1508222226540.3873@nanos>
Message-ID: <20150822211718.GA8561@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Aug 22, 2015 at 10:33:48PM +0200, Thomas Gleixner wrote:
> > @@ -196,19 +197,31 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
> >  			break;
> >  		}
> >  		pct = &sysoff->ts[0];
> > -		for (i = 0; i < sysoff->n_samples; i++) {
> > -			getnstimeofday64(&ts);
> > +		if (ptp->info->getsynctime64 && sysoff->n_samples == 1 &&
> 
> The number of samples should be irrelevant for this sampling method.

Chris had send me a preview of this before he posted, so I can explain
that test for one sample.

User space requests N (1 to 25) samples of the two clocks.  The kernel
is supposed to deliver that many samples.  This has always been the
documented behavior.  From ptp_clock.h:

  struct ptp_sys_offset {
	unsigned int n_samples; /* Desired number of measurements. */
	unsigned int rsv[3];    /* Reserved for future use. */
	/*
	 * Array of interleaved system/phc time stamps. The kernel
	 * will provide 2*n_samples + 1 time stamps, with the last
	 * one as a system time stamp.
	 */
	struct ptp_clock_time ts[2 * PTP_MAX_SAMPLES + 1];
  };

So the kernel cannot simply change n_samples to 1.

I would prefer to have a new system call that compares any two posix
clock_t, but that is of course more work.

Allowing n_samples=1 as a special case is a kind of overloading of the
ioctl to support the new capability.  At least it preserves the
behavior of the interface from the user's perspective.

Thanks,
Richard
