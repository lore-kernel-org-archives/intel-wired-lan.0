From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 22:18:37 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v1 2/2] igc: Save PTP time
 before a reset
In-Reply-To: <20200820230217.2005122-2-vinicius.gomes@intel.com>
References: <20200820230217.2005122-1-vinicius.gomes@intel.com>
 <20200820230217.2005122-2-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB289070D70BFAB75573FAFF8CBC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Thursday, August 20, 2020 4:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [PATCH next-queue v1 2/2] igc: Save PTP time before a
> reset
> 
> Many TSN features depend on the internal PTP clock, so the internal
> PTP jumping when the adapter is reset can cause problems, usually in
> the form of "TX Hangs" warnings in the driver.
> 
> The solution is to save the PTP time before a reset and restore it
> after the reset is done. The value of the PTP time is saved before a
> reset and we use the difference from CLOCK_MONOTONIC from reset time
> to now, to correct what's going to be the new PTP time.
> 
> This is heavily inspired by commit bf4bf09 ("i40e: save PTP
> time before a device reset").
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>  drivers/net/ethernet/intel/igc/igc_main.c |  2 ++
>  drivers/net/ethernet/intel/igc/igc_ptp.c  | 28 ++++++++++++++++++++---
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h
> b/drivers/net/ethernet/intel/igc/igc.h
> index 522699b870c9..ad9e2ef80043 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -219,6 +219,8 @@ struct igc_adapter {
>  	spinlock_t tmreg_lock;
>  	struct cyclecounter cc;
>  	struct timecounter tc;
> +	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
> +	ktime_t ptp_reset_start; /* Reset time in clock mono */
>  };
> 
>  void igc_up(struct igc_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 933e0d3445df..e685a1c3269f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3788,6 +3788,8 @@ void igc_down(struct igc_adapter *adapter)
> 
>  	set_bit(__IGC_DOWN, &adapter->state);
> 
> +	igc_ptp_suspend(adapter);
> +
>  	/* disable receives in the hardware */
>  	rctl = rd32(IGC_RCTL);
>  	wr32(IGC_RCTL, rctl & ~IGC_RCTL_EN);
>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
