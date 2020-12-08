From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 8 Dec 2020 04:35:23 -0800
Subject: [Intel-wired-lan] [PATCH v8] i40e: add support for PTP external
 synchronization clock
In-Reply-To: <20201208154119.106511-1-piotr.kwapulinski@intel.com>
References: <3dcb78c0-b4cf-8686-20d6-3cd766e7fb1a@molgen.mpg.de>
 <20201208154119.106511-1-piotr.kwapulinski@intel.com>
Message-ID: <20201208123523.GA17489@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 08, 2020 at 03:41:19PM +0000, Piotr Kwapulinski wrote:

> @@ -145,14 +398,35 @@ static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
>  static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  {
>  	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
> -	struct timespec64 now, then;
> +	struct i40e_hw *hw = &pf->hw;
>  
> -	then = ns_to_timespec64(delta);
>  	mutex_lock(&pf->tmreg_lock);
>  
> -	i40e_ptp_read(pf, &now, NULL);
> -	now = timespec64_add(now, then);
> -	i40e_ptp_write(pf, (const struct timespec64 *)&now);
> +	if (delta > -999999900LL && delta < 999999900LL) {
> +		int neg_adj = 0;
> +		u32 timadj;
> +		u64 tohw;
> +
> +		if (delta < 0) {
> +			neg_adj = 1;
> +			tohw = -delta;
> +		} else {
> +			tohw = delta;
> +		}
> +
> +		timadj = tohw & 0x3FFFFFFF;
> +		if (neg_adj)
> +			timadj |= I40E_ISGN;
> +		wr32(hw, I40E_PRTTSYN_ADJ, timadj);
> +	} else {
> +		struct timespec64 then, now;
> +
> +		then = ns_to_timespec64(delta);
> +		i40e_ptp_read(pf, &now, NULL);
> +		now = timespec64_add(now, then);
> +		i40e_ptp_write(pf, (const struct timespec64 *)&now);
> +		i40e_ptp_set_1pps_signal_hw(pf);

This enables a 1-PPS hardware output unconditionally?

> +	}
>  
>  	mutex_unlock(&pf->tmreg_lock);
>  

> @@ -839,6 +1492,8 @@ void i40e_ptp_init(struct i40e_pf *pf)
>  		/* Restore the clock time based on last known value */
>  		i40e_ptp_restore_hw_time(pf);
>  	}
> +
> +	i40e_ptp_set_1pps_signal_hw(pf);
>  }

Here again the 1-PPS is enabled unconditionally.

Instead, why not allow the user to enable/disable this?

There is a new ioctl variant designed for periodic outputs like a PPS.

Bits of the ptp_perout_request.flags field can contain:

 PTP_PEROUT_DUTY_CYCLE
 PTP_PEROUT_PHASE

You can enable the PPS when they are present in the request.

Thanks,
Richard
