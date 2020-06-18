From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 Jun 2020 17:18:03 +0000
Subject: [Intel-wired-lan] [PATCH 1/6] igc: Clean up rx timestamping
 logic
In-Reply-To: <20200604000105.15059-2-andre.guedes@intel.com>
References: <20200604000105.15059-1-andre.guedes@intel.com>
 <20200604000105.15059-2-andre.guedes@intel.com>
Message-ID: <DM6PR11MB289093D87D5DACF030E9AE32BC9B0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, June 3, 2020 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/6] igc: Clean up rx timestamping logic
> 
> Differently from I210, I225 doesn't report rx timestamps via the TS bit
> rx descriptor + RXSTMPL/RXSTMPH registers mechanism. Rx timestamps are
> reported in the packet buffer only, which is implemented by igc_ptp_rx_
> pktstamp(). So this patch removes igc_ptp_rx_rgtstamp() and all code
> related to it, copied from igb driver.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  3 --
>  drivers/net/ethernet/intel/igc/igc_defines.h |  2 -
>  drivers/net/ethernet/intel/igc/igc_main.c    | 12 ++----
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 44 +-------------------
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  2 -
>  5 files changed, 5 insertions(+), 58 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
