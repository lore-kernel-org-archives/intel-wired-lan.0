From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 26 Oct 2018 15:16:47 -0700
Subject: [Intel-wired-lan] [RFC PATCH 1/4] ptp: add
 PTP_SYS_OFFSET_EXTENDED ioctl
In-Reply-To: <20181026162742.631-2-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-2-mlichvar@redhat.com>
Message-ID: <87in1o73qo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Miroslav,

Miroslav Lichvar <mlichvar@redhat.com> writes:

> The PTP_SYS_OFFSET ioctl, which can be used to measure the offset
> between a PHC and the system clock, includes the total time that the
> gettime64 function of a driver needs to read the PHC timestamp.
>
> This typically involves reading of multiple PCI registers (sometimes in
> multiple iterations) and the register that contains the lowest bits of
> the timestamp is not read in the middle between the two readings of the
> system clock. This asymmetry causes the measured offset to have a
> significant error.
>
> Introduce a new ioctl, driver function, and helper functions, which
> allow the reading of the lowest register to be isolated from the other
> readings in order to reduce the asymmetry. The ioctl and driver function
> return three timestamps for each measurement:
> - system time right before reading the lowest bits of the PHC timestamp
> - PHC time
> - system time immediately after reading the lowest bits of the PHC
>   timestamp

Cool stuff!

Just one little thing below. Feel free to add my ack to the series.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/ptp/ptp_chardev.c        | 39 ++++++++++++++++++++++++++++++++
>  include/linux/ptp_clock_kernel.h | 26 +++++++++++++++++++++
>  include/uapi/linux/ptp_clock.h   | 12 ++++++++++
>  3 files changed, 77 insertions(+)
>
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 2012551d93e0..1a04c437fd4f 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -124,11 +124,13 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  	struct ptp_clock_caps caps;
>  	struct ptp_clock_request req;
>  	struct ptp_sys_offset *sysoff = NULL;
> +	struct ptp_sys_offset_extended *sysoff_extended = NULL;
>  	struct ptp_sys_offset_precise precise_offset;
>  	struct ptp_pin_desc pd;
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
>  	struct ptp_clock_info *ops = ptp->info;
>  	struct ptp_clock_time *pct;
> +	struct ptp_system_timestamp sts;
>  	struct timespec64 ts;
>  	struct system_device_crosststamp xtstamp;
>  	int enable, err = 0;
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

Looks like you forgot to free 'sysoff_extended', no? 


--
Vinicius
