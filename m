From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Thu, 26 Aug 2021 06:20:56 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-next 4/4] ice: Implement
 support for SMA and U.FL on E810-T
In-Reply-To: <20210817110918.1937113-5-maciej.machnikowski@intel.com>
References: <20210817110918.1937113-1-maciej.machnikowski@intel.com>
 <20210817110918.1937113-5-maciej.machnikowski@intel.com>
Message-ID: <CO1PR11MB50285E79BD16A0E3AEB196EBA0C79@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Machnikowski
> Sent: Tuesday, August 17, 2021 4:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-next 4/4] ice: Implement support for SMA and U.FL on E810-T
>
> Expose SMA and U.FL connectors as ptp_pins on E810-T based adapters and allow controlling them.
>
> E810-T adapters are equipped with:
> - 2 external bidirectional SMA connectors
> - 1 internal TX U.FL
> - 1 internal RX U.FL
>
> U.FL connectors share signal lines with the SMA connectors. The TX U.FL1 share the line with the SMA1 and the RX U.FL2 share line with the SMA2.
> This dependence is controlled by the ice_verify_pin_e810t.
>
> Additionally add support for the E810-T-based  devices which don't use the SMA/U.FL controller. If the IO expander is not detected don't expose pins and use 2 predefined 1PPS input and output pins.
>
>Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice.h     |   1 +
> drivers/net/ethernet/intel/ice/ice_lib.c |  15 +
> drivers/net/ethernet/intel/ice/ice_lib.h |   1 +
> drivers/net/ethernet/intel/ice/ice_ptp.c | 374 ++++++++++++++++++++++-  drivers/net/ethernet/intel/ice/ice_ptp.h |  21 +-
> 5 files changed, 402 insertions(+), 10 deletions(-)
>
Tested-by: Mekala, Sunitha D <sunithax.d.mekala@intel.com > (A Contingent worker at Intel) 

