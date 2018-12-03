From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 3 Dec 2018 21:36:49 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: extend PTP gettime function to
 read system clock
In-Reply-To: <20181128160749.14040-1-mlichvar@redhat.com>
References: <20181128160749.14040-1-mlichvar@redhat.com>
Message-ID: <02874ECE860811409154E81DA85FBB588D52B52A@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Wednesday, November 28, 2018 8:08 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Miroslav Lichvar <mlichvar@redhat.com>; Richard Cochran
> <richardcochran@gmail.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH] i40e: extend PTP gettime function to read system clock
> 
> This adds support for the PTP_SYS_OFFSET_EXTENDED ioctl.
> 
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

Nice! Thanks Miroslav.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index e6fc0aff8c99..5fb4353c742b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -28,19 +28,23 @@
>   * i40e_ptp_read - Read the PHC time from the device
>   * @pf: Board private structure
>   * @ts: timespec structure to hold the current time value
> + * @sts: structure to hold the system time before and after reading the PHC
>   *
>   * This function reads the PRTTSYN_TIME registers and stores them in a
>   * timespec. However, since the registers are 64 bits of nanoseconds, we must
>   * convert the result to a timespec before we can return.
>   **/
> -static void i40e_ptp_read(struct i40e_pf *pf, struct timespec64 *ts)
> +static void i40e_ptp_read(struct i40e_pf *pf, struct timespec64 *ts,
> +			  struct ptp_system_timestamp *sts)
>  {
>  	struct i40e_hw *hw = &pf->hw;
>  	u32 hi, lo;
>  	u64 ns;
> 
>  	/* The timer latches on the lowest register read. */
> +	ptp_read_system_prets(sts);
>  	lo = rd32(hw, I40E_PRTTSYN_TIME_L);
> +	ptp_read_system_postts(sts);
>  	hi = rd32(hw, I40E_PRTTSYN_TIME_H);
> 
>  	ns = (((u64)hi) << 32) | lo;
> @@ -146,7 +150,7 @@ static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64
> delta)
> 
>  	mutex_lock(&pf->tmreg_lock);
> 
> -	i40e_ptp_read(pf, &now);
> +	i40e_ptp_read(pf, &now, NULL);
>  	timespec64_add_ns(&now, delta);
>  	i40e_ptp_write(pf, (const struct timespec64 *)&now);
> 
> @@ -156,19 +160,21 @@ static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64
> delta)
>  }
> 
>  /**
> - * i40e_ptp_gettime - Get the time of the PHC
> + * i40e_ptp_gettimex - Get the time of the PHC
>   * @ptp: The PTP clock structure
>   * @ts: timespec structure to hold the current time value
> + * @sts: structure to hold the system time before and after reading the PHC
>   *
>   * Read the device clock and return the correct value on ns, after converting it
>   * into a timespec struct.
>   **/
> -static int i40e_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
> +static int i40e_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
> +			     struct ptp_system_timestamp *sts)
>  {
>  	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
> 
>  	mutex_lock(&pf->tmreg_lock);
> -	i40e_ptp_read(pf, ts);
> +	i40e_ptp_read(pf, ts, sts);
>  	mutex_unlock(&pf->tmreg_lock);
> 
>  	return 0;
> @@ -702,7 +708,7 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
>  	pf->ptp_caps.pps = 0;
>  	pf->ptp_caps.adjfreq = i40e_ptp_adjfreq;
>  	pf->ptp_caps.adjtime = i40e_ptp_adjtime;
> -	pf->ptp_caps.gettime64 = i40e_ptp_gettime;
> +	pf->ptp_caps.gettimex64 = i40e_ptp_gettimex;
>  	pf->ptp_caps.settime64 = i40e_ptp_settime;
>  	pf->ptp_caps.enable = i40e_ptp_feature_enable;
> 
> --
> 2.17.2

