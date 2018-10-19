From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 19 Oct 2018 16:56:02 +0000
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: allow non-monotonic
 SYSTIM readings
In-Reply-To: <20181017161621.6081-1-mlichvar@redhat.com>
References: <20181017161621.6081-1-mlichvar@redhat.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884CDDA0E@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Miroslav

> -----Original Message-----
> From: Miroslav Lichvar [mailto:mlichvar at redhat.com]
> Sent: Wednesday, October 17, 2018 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Miroslav Lichvar <mlichvar@redhat.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Richard Cochran <richardcochran@gmail.com>
> Subject: [RFC PATCH] e1000e: allow non-monotonic SYSTIM readings
> 
> It seems with some NICs supported by the e1000e driver a SYSTIM reading
> may occasionally be few microseconds before the previous reading and if
> enabled also pass e1000e_sanitize_systim() without reaching the maximum
> number of rereads, even if the function is modified to check three
> consecutive readings (i.e. it doesn't look like a double read error).
> This causes an underflow in the timecounter and the PHC time jumps hours
> ahead.
> 
> This was observed on 82574, I217 and I219. The fastest way to reproduce
> it is to run a program that continuously calls the PTP_SYS_OFFSET ioctl
> on the PHC.
> 

Ouch. Good catch.

> Modify e1000e_phc_gettime() to use timecounter_cyc2time() instead of
> timecounter_read() in order to allow non-monotonic SYSTIM readings and
> prevent the PHC from jumping.
> 

Right. I think this makes sense. It does mean we will report the clock jumping back, but that *is* what the hardware reports here so I think it makes sense.

> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ptp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c
> b/drivers/net/ethernet/intel/e1000e/ptp.c
> index 37c76945ad9b..ec6477c88a4f 100644
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
> @@ -233,6 +237,9 @@ static void e1000e_systim_overflow_work(struct
> work_struct *work)
>  	struct e1000_hw *hw = &adapter->hw;
>  	struct timespec64 ts;
> 
> +	/* Update the timecounter */
> +	timecounter_read(&adapter->tc);
> +

yea, we previously depended on the gettime64 to do timecounter_read implicitly.

>  	adapter->ptp_clock_info.gettime64(&adapter->ptp_clock_info, &ts);

Can't we drop this line now?

> 
>  	e_dbg("SYSTIM overflow check at %lld.%09lu\n",
> --
> 2.17.1

