From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 30 Oct 2018 19:23:51 -0700
Subject: [Intel-wired-lan] [RFC PATCH 1/4] ptp: add
 PTP_SYS_OFFSET_EXTENDED ioctl
In-Reply-To: <20181026162742.631-2-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-2-mlichvar@redhat.com>
Message-ID: <20181031022351.24mmvf7u7bcx42rv@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 26, 2018 at 06:27:39PM +0200, Miroslav Lichvar wrote:
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 2012551d93e0..1a04c437fd4f 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -124,11 +124,13 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  	struct ptp_clock_caps caps;
>  	struct ptp_clock_request req;
>  	struct ptp_sys_offset *sysoff = NULL;
> +	struct ptp_sys_offset_extended *sysoff_extended = NULL;

How about a more succinct name, like 'extoff' ?

>  	struct ptp_sys_offset_precise precise_offset;
>  	struct ptp_pin_desc pd;
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
>  	struct ptp_clock_info *ops = ptp->info;
>  	struct ptp_clock_time *pct;
> +	struct ptp_system_timestamp sts;
>  	struct timespec64 ts;
>  	struct system_device_crosststamp xtstamp;
>  	int enable, err = 0;

This collection of automatic variables is getting ugly.  May I ask you
to prefix a patch that puts them into reverse Christmas tree before
your changes?  (Patch below)

> @@ -211,6 +213,43 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  			err = -EFAULT;
>  		break;
>  
> +	case PTP_SYS_OFFSET_EXTENDED:
> +		if (!ptp->info->gettimex64) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}
> +		sysoff_extended = memdup_user((void __user *)arg,
> +					      sizeof(*sysoff_extended));

As pointed out before, this needs to be freed, and

> +		if (IS_ERR(sysoff_extended)) {
> +			err = PTR_ERR(sysoff_extended);
> +			sysoff = NULL;

here you meant, sysoff_extended = NULL;

> +			break;
> +		}
> +		if (sysoff_extended->n_samples > PTP_MAX_SAMPLES) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		pct = &sysoff_extended->ts[0];
> +		for (i = 0; i < sysoff_extended->n_samples; i++) {
> +			err = ptp->info->gettimex64(ptp->info, &sts);
> +			if (err)
> +				break;
> +			pct->sec = sts.sys_ts1.tv_sec;
> +			pct->nsec = sts.sys_ts1.tv_nsec;
> +			pct++;
> +			pct->sec = sts.phc_ts.tv_sec;
> +			pct->nsec = sts.phc_ts.tv_nsec;
> +			pct++;
> +			pct->sec = sts.sys_ts2.tv_sec;
> +			pct->nsec = sts.sys_ts2.tv_nsec;
> +			pct++;
> +		}
> +		if (copy_to_user((void __user *)arg, sysoff_extended,
> +				 sizeof(*sysoff_extended)))
> +			err = -EFAULT;
> +		break;
> +
>  	case PTP_SYS_OFFSET:
>  		sysoff = memdup_user((void __user *)arg, sizeof(*sysoff));
>  		if (IS_ERR(sysoff)) {
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 51349d124ee5..79321d929925 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -39,6 +39,13 @@ struct ptp_clock_request {
>  };
>  
>  struct system_device_crosststamp;
> +

KernelDoc please for this:

> +struct ptp_system_timestamp {
> +	struct timespec64 sys_ts1;
> +	struct timespec64 phc_ts;
> +	struct timespec64 sys_ts2;
> +};
> +

Thanks,
Richard
