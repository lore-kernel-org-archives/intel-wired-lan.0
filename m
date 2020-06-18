From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 Jun 2020 17:18:24 +0000
Subject: [Intel-wired-lan] [PATCH 2/6] igc: Remove duplicate code in tx
 timestamp handling
In-Reply-To: <20200604000105.15059-3-andre.guedes@intel.com>
References: <20200604000105.15059-1-andre.guedes@intel.com>
 <20200604000105.15059-3-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28908B8A22A90ADDE832CDC6BC9B0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, June 3, 2020 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/6] igc: Remove duplicate code in tx
> timestamp handling
> 
> The functions igc_ptp_tx_hang() and igc_ptp_tx_work() have duplicate
> code which handles tx timestamp timeouts. This patch does a trivial
> refactoring by moving that code to its own function and reusing it.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 34 +++++++++++-------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
