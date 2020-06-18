From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 Jun 2020 17:18:46 +0000
Subject: [Intel-wired-lan] [PATCH 3/6] igc: Check
 __IGC_PTP_TX_IN_PROGRESS instead of ptp_tx_skb
In-Reply-To: <20200604000105.15059-4-andre.guedes@intel.com>
References: <20200604000105.15059-1-andre.guedes@intel.com>
 <20200604000105.15059-4-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890D59061828D04910CCC5ABC9B0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, June 3, 2020 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/6] igc: Check
> __IGC_PTP_TX_IN_PROGRESS instead of ptp_tx_skb
> 
> The __IGC_PTP_TX_IN_PROGRESS flag indicates we have a pending tx
> timestamp. In some places, instead of checking that flag, we check
> adapter->ptp_tx_skb. This patch fixes those places to use the flag.
> 
> Quick note about igc_ptp_tx_hwtstamp() change: when that function is
> called, adapter->ptp_tx_skb is expected to be valid always so we
> WARN_ON_ONCE() in case it is not.
> 
> Quick note about igc_ptp_suspend() change: when suspending, we don't
> really need to check if there is a pending timestamp. We can simply
> clear it unconditionally.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
