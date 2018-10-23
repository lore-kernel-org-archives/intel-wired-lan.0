From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 23 Oct 2018 16:32:50 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: allow non-monotonic SYSTIM
 readings
In-Reply-To: <20181023123739.12489-1-mlichvar@redhat.com>
References: <20181023123739.12489-1-mlichvar@redhat.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884CE17CD@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Tuesday, October 23, 2018 5:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Miroslav Lichvar <mlichvar@redhat.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Richard Cochran <richardcochran@gmail.com>
> Subject: [PATCH v1] e1000e: allow non-monotonic SYSTIM readings
> 
> It seems with some NICs supported by the e1000e driver a SYSTIM reading
> may occasionally be few microseconds before the previous reading and if
> enabled also pass e1000e_sanitize_systim() without reaching the maximum
> number of rereads, even if the function is modified to check three
> consecutive readings (i.e. it doesn't look like a double read error).
> This causes an underflow in the timecounter and the PHC time jumps hours
> ahead.
> 

Weird issue, but I think this is a better solution than returning garbage time data like we were before.

> This was observed on 82574, I217 and I219. The fastest way to reproduce
> it is to run a program that continuously calls the PTP_SYS_OFFSET ioctl
> on the PHC.
> 
> Modify e1000e_phc_gettime() to use timecounter_cyc2time() instead of
> timecounter_read() in order to allow non-monotonic SYSTIM readings and
> prevent the PHC from jumping.
> 

Thanks for the patch. This looks good to me.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
> 
> Notes:
>     RFC->v1:
>     - Removed unnecessary call of PTP gettime64() in
>       e1000e_systim_overflow_work()
> 
>  drivers/net/ethernet/intel/e1000e/ptp.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c
> b/drivers/net/ethernet/intel/e1000e/ptp.c
> index 37c76945ad9b..e1f821edbc21 100644
> --- a/drivers/net/ethernet/intel/e1000e/ptp.c
> +++ b/drivers/net/ethernet/intel/e1000e/ptp.c
> @@ -173,10 +173,14 @@ static int e1000e_phc_gettime(struct ptp_clock_info *ptp,
> struct timespec64 *ts)
>  	struct e1000_adapter *adapter = container_of(ptp, struct e1000_adapter,
>  						     ptp_clock_info);
>  	unsigned long flags;
> -	u64 ns;
> +	u64 cycles, ns;
> 
>  	spin_lock_irqsave(&adapter->systim_lock, flags);
> -	ns = timecounter_read(&adapter->tc);
> +
> +	/* Use timecounter_cyc2time() to allow non-monotonic SYSTIM readings */
> +	cycles = adapter->cc.read(&adapter->cc);
> +	ns = timecounter_cyc2time(&adapter->tc, cycles);
> +
>  	spin_unlock_irqrestore(&adapter->systim_lock, flags);
> 
>  	*ts = ns_to_timespec64(ns);
> @@ -232,9 +236,12 @@ static void e1000e_systim_overflow_work(struct
> work_struct *work)
>  						     systim_overflow_work.work);
>  	struct e1000_hw *hw = &adapter->hw;
>  	struct timespec64 ts;
> +	u64 ns;
> 
> -	adapter->ptp_clock_info.gettime64(&adapter->ptp_clock_info, &ts);
> +	/* Update the timecounter */
> +	ns = timecounter_read(&adapter->tc);
> 
> +	ts = ns_to_timespec64(ns);
>  	e_dbg("SYSTIM overflow check at %lld.%09lu\n",
>  	      (long long) ts.tv_sec, ts.tv_nsec);
> 
> --
> 2.17.1

