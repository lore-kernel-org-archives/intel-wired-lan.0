From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Nov 2019 19:06:58 +0000
Subject: [Intel-wired-lan] [PATCH net 01/13] ptp: Validate requests to
 enable time stamping of external signals.
In-Reply-To: <20191114184507.18937-2-richardcochran@gmail.com>
References: <20191114184507.18937-2-richardcochran@gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB589698F67E@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Thursday, November 14, 2019 10:45 AM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; David Miller <davem@davemloft.net>;
> Brandon Streiff <brandon.streiff@ni.com>; Hall, Christopher S
> <christopher.s.hall@intel.com>; Eugenia Emantayev <eugenia@mellanox.com>;
> Felipe Balbi <felipe.balbi@linux.intel.com>; Feras Daoud
> <ferasda@mellanox.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>; Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com>; Stefan Sorensen
> <stefan.sorensen@spectralink.com>
> Subject: [PATCH net 01/13] ptp: Validate requests to enable time stamping of
> external signals.
> 
> Commit 415606588c61 ("PTP: introduce new versions of IOCTLs")
> introduced a new external time stamp ioctl that validates the flags.
> This patch extends the validation to ensure that at least one rising
> or falling edge flag is set when enabling external time stamps.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> ---
>  drivers/ptp/ptp_chardev.c      | 18 +++++++++++++-----
>  include/uapi/linux/ptp_clock.h |  1 +
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 67d0199840fd..cbbe1237ff8d 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -149,11 +149,19 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd,
> unsigned long arg)
>  			err = -EFAULT;
>  			break;
>  		}
> -		if (((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
> -			req.extts.rsv[0] || req.extts.rsv[1]) &&
> -			cmd == PTP_EXTTS_REQUEST2) {
> -			err = -EINVAL;
> -			break;
> +		if (cmd == PTP_EXTTS_REQUEST2) {
> +			/* Make sure no reserved bit is set. */
> +			if ((req.extts.flags & ~PTP_EXTTS_VALID_FLAGS) ||
> +			    req.extts.rsv[0] || req.extts.rsv[1]) {
> +				err = -EINVAL;
> +				break;
> +			}
> +			/* Ensure one of the rising/falling edge bits is set. */
> +			if ((req.extts.flags & PTP_ENABLE_FEATURE) &&
> +			    (req.extts.flags & PTP_EXTTS_EDGES) == 0) {
> +				err = -EINVAL;
> +				break;
> +			}

Just to confirm, these new ioctls haven't been around long enough to be concerned about this change?

Thanks,
Jake

