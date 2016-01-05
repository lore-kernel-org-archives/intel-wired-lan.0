From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 5 Jan 2016 16:27:32 +0100
Subject: [Intel-wired-lan] [RFC v5 5/6] Add PTP_SYS_OFFSET_PRECISE for
 driver crosstimestamping
In-Reply-To: <1451911523-8534-6-git-send-email-christopher.s.hall@intel.com>
References: <1451911523-8534-1-git-send-email-christopher.s.hall@intel.com>
 <1451911523-8534-6-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20160105152731.GA24372@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 04, 2016 at 04:45:22AM -0800, Christopher S. Hall wrote:
> @@ -138,6 +142,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  		caps.n_per_out = ptp->info->n_per_out;
>  		caps.pps = ptp->info->pps;
>  		caps.n_pins = ptp->info->n_pins;
> +		caps.cross_timestamping = ptp->info->getsynctime != NULL;
>  		if (copy_to_user((void __user *)arg, &caps, sizeof(caps)))
>  			err = -EFAULT;
>  		break;
> @@ -180,6 +185,32 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  		err = ops->enable(ops, &req, enable);
>  		break;
>  
> +	case PTP_SYS_OFFSET_PRECISE:
> +		if (!ptp->info->getsynctime) {
> +			err = -EINVAL;

-EOPNOTSUPP would be better here.

> +			break;
> +		}
> +		err = ptp->info->getsynctime(ptp->info, &xtstamp);
> +		if (err)
> +			break;
> +
> +		precise_offset.sys_real.sec =
> +			div_u64_rem(ktime_to_ns(xtstamp.sys_realtime),
> +				    NSEC_PER_SEC, &rem);
> +		precise_offset.sys_real.nsec = rem;

How about this instead:

		ts = ktime_to_timespec64(xtstamp.sys_realtime);
		precise_offset.sys_real.sec = ts.tv_sec;
		precise_offset.sys_real.nsec = ts.tv_nsec;

> +		precise_offset.sys_raw.sec =
> +			div_u64_rem(ktime_to_ns(xtstamp.sys_monoraw),
> +				    NSEC_PER_SEC, &rem);
> +		precise_offset.sys_raw.nsec = rem;
> +		precise_offset.dev.sec =
> +			div_u64_rem(ktime_to_ns(xtstamp.device), NSEC_PER_SEC,
> +				    &rem);
> +		precise_offset.dev.nsec = rem;

And for these as well.

Thanks,
Richard
