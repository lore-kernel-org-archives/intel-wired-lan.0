From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 22 Aug 2015 22:33:48 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH v3 3/4] Add support for driver
 cross-timestamp to PTP_SYS_OFFSET ioctl
In-Reply-To: <1440183128-1384-4-git-send-email-christopher.s.hall@intel.com>
References: <1440183128-1384-1-git-send-email-christopher.s.hall@intel.com>
 <1440183128-1384-4-git-send-email-christopher.s.hall@intel.com>
Message-ID: <alpine.DEB.2.11.1508222226540.3873@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 21 Aug 2015, Christopher S. Hall wrote:
> From: Christopher Hall <christopher.s.hall@intel.com>
> 
> This patch allows system and device time ("cross-timestamp") to be
> performed by the driver. Currently, the cross-timestamping is performed
> in the PTP_SYS_OFFSET ioctl.  The PTP clock driver reads gettimeofday()
> and the gettime64() callback provided by the driver. The cross-timestamp
> is best effort where the latency between the capture of system time
> (getnstimeofday()) and the device time (driver callback) may be
> significant.
> 
> This patch adds an additional callback getsynctime64(). Which will be
> called when the driver is able to perform a more accurate, implementation
> specific cross-timestamping.  For example, future network devices that
> implement PCIE PTM will be able to precisely correlate the device clock
> with the system clock with virtually zero latency between captures.
> This added callback can be used by the driver to expose this functionality.
> 
> The callback, getsynctime64(), will only be called when defined and
> n_samples == 1 because the driver returns only 1 cross-timestamp where
> multiple samples cannot be chained together.
> 
> This patch also adds to the capabilities ioctl (PTP_CLOCK_GETCAPS),
> allowing applications to query whether or not drivers implement the
> getsynctime callback, providing more precise cross timestamping.

That looks close to a proper changelog. A few nitpicks though.

Please avoid 'This patch does ...' phrases. We already know that this
is a patch.


> Commit Details:

Please get rid of this. It's useless noise.
 
> Added additional callback to ptp_clock_info:
> 
> * getsynctime64()

> @@ -196,19 +197,31 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  			break;
>  		}
>  		pct = &sysoff->ts[0];
> -		for (i = 0; i < sysoff->n_samples; i++) {
> -			getnstimeofday64(&ts);
> +		if (ptp->info->getsynctime64 && sysoff->n_samples == 1 &&

The number of samples should be irrelevant for this sampling method.

> +		    ptp->info->getsynctime64(ptp->info, &ts, &systs) == 0) {

Why is this function taking struct timespec64 pointers? Just so every
driver which implements the callback needs to convert from u64 to
struct timespec64? That's simply wrong. Use u64 for both and do the
conversion in the ioctl.

Thanks,

	tglx
