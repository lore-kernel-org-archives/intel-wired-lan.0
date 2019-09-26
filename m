From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 25 Sep 2019 20:43:44 -0700
Subject: [Intel-wired-lan] [net-next v2 1/2] ptp: correctly disable
 flags on old ioctls
In-Reply-To: <20190926022820.7900-2-jacob.e.keller@intel.com>
References: <20190926022820.7900-1-jacob.e.keller@intel.com>
 <20190926022820.7900-2-jacob.e.keller@intel.com>
Message-ID: <20190926034344.GA21883@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 25, 2019 at 07:28:19PM -0700, Jacob Keller wrote:
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 9c18476d8d10..67d0199840fd 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -155,7 +155,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  			err = -EINVAL;
>  			break;
>  		} else if (cmd == PTP_EXTTS_REQUEST) {
> -			req.extts.flags &= ~PTP_EXTTS_VALID_FLAGS;
> +			req.extts.flags &= PTP_EXTTS_V1_VALID_FLAGS;

Duh, the bit wise negation was not the intention.  Thanks for catching
this, and introducing the "V1" set of flags makes sense.

@davem Please merge this patch as a bug fix.

Acked-by: Richard Cochran <richardcochran@gmail.com>
