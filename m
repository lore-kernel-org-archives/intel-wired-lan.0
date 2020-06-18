From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 Jun 2020 17:19:56 +0000
Subject: [Intel-wired-lan] [PATCH 6/6] igc: Fix rx timestamp disabling
In-Reply-To: <20200604000105.15059-7-andre.guedes@intel.com>
References: <20200604000105.15059-1-andre.guedes@intel.com>
 <20200604000105.15059-7-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890FCB8221C0091075DA502BC9B0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, June 3, 2020 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 6/6] igc: Fix rx timestamp disabling
> 
> When rx timestamping is enabled, we set the timestamp bit in SRRCTL
> register for each queue, but we don't clear it when disabling. This
> patch fixes igc_ptp_disable_rx_timestamp() accordingly.
> 
> Also, this patch gets rid of igc_ptp_enable_tstamp_rxqueue() and
> igc_ptp_enable_tstamp_all_rxqueues() and move their logic into
> igc_ptp_enable_rx_timestamp() to keep the enable and disable
> helpers symmetric.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 54 ++++++++----------------
>  1 file changed, 17 insertions(+), 37 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
