From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 27 Aug 2021 23:40:02 +0000
Subject: [Intel-wired-lan] [PATCH] igc: optimize
 igc_ptp_systim_to_hwtstamp()
In-Reply-To: <20210827171515.2518713-1-trix@redhat.com>
References: <20210827171515.2518713-1-trix@redhat.com>
Message-ID: <73b1637111236bebeeff08d3275ddd5d1da9637d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-08-27 at 10:15 -0700, trix at redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this representative problem
> igc_ptp.c:676:3: warning: The left operand of '+' is a garbage value
>                 ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>                 ^            ~~~~~~~~~~~~~~~~~~~~
> 
> The issue is flagged because the setting of shhwtstamps is
> in igc_ptp_systim_to_hwtstamp() it is set only in one path through
> this switch.
> 
> 	switch (adapter->hw.mac.type) {
> 	case igc_i225:
> 		memset(hwtstamps, 0, sizeof(*hwtstamps));
> 		/* Upper 32 bits contain s, lower 32 bits contain ns.
> */
> 		hwtstamps->hwtstamp = ktime_set(systim >> 32,
> 						systim & 0xFFFFFFFF);
> 		break;
> 	default:
> 		break;
> 	}
> 
> Changing the memset the a caller initialization is a small
> optimization
> and will resolve uninitialized use issue.
> 
> A switch statement with one case is overkill, convert to an if
> statement.
> 
> This function is small and only called once, change to inline for an
> expected small runtime and size improvement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c
> b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index 0f021909b430a0..1443a2da246e22 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -417,20 +417,14 @@ static int igc_ptp_verify_pin(struct
> ptp_clock_info *ptp, unsigned int pin,
>   * We need to convert the system time value stored in the RX/TXSTMP
> registers
>   * into a hwtstamp which can be used by the upper level timestamping
> functions.
>   **/
> -static void igc_ptp_systim_to_hwtstamp(struct igc_adapter *adapter,
> -				       struct skb_shared_hwtstamps
> *hwtstamps,
> -				       u64 systim)
> +static inline void igc_ptp_systim_to_hwtstamp(struct igc_adapter
> *adapter,

Please don't use inline in C files, let the compiler decide.

> +					      struct
> skb_shared_hwtstamps *hwtstamps,
> +					      u64 systim)
>  {
> -	switch (adapter->hw.mac.type) {
> -	case igc_i225:
> -		memset(hwtstamps, 0, sizeof(*hwtstamps));
> -		/* Upper 32 bits contain s, lower 32 bits contain ns.
> */
> +	/* Upper 32 bits contain s, lower 32 bits contain ns. */
> +	if (adapter->hw.mac.type == igc_i225)
>  		hwtstamps->hwtstamp = ktime_set(systim >> 32,
>  						systim & 0xFFFFFFFF);
> -		break;
> -	default:
> -		break;
> -	}
>  }
>  
>  /**
> @@ -645,7 +639,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
>  static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
>  {
>  	struct sk_buff *skb = adapter->ptp_tx_skb;
> -	struct skb_shared_hwtstamps shhwtstamps;
> +	struct skb_shared_hwtstamps shhwtstamps = { 0 };

Need to re-order for RCT.

Thanks,
Tony

>  	struct igc_hw *hw = &adapter->hw;
>  	int adjust = 0;
>  	u64 regval;
