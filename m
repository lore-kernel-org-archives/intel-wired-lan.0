From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Tue, 5 Oct 2021 16:27:21 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-next 3/4] ice: Add support
 for SMA control multiplexer
In-Reply-To: <20210817110918.1937113-4-maciej.machnikowski@intel.com>
References: <20210817110918.1937113-1-maciej.machnikowski@intel.com>
 <20210817110918.1937113-4-maciej.machnikowski@intel.com>
Message-ID: <CO1PR11MB502886072DC33688FB7F8BFEA0AF9@CO1PR11MB5028.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 intel-next 3/4] ice: Add support for SMA control multiplexer
>
> E810-T adapters have two external bidirectional SMA connectors and two internal unidirectional U.FL connectors. Multiplexing between U.FL and SMA and SMA direction is controlled using the PCA9575 expander.
>
> Add support for the PCA9575 detection and control of the respective pins of the SMA/U.FL multiplexer using the GPIO AQ API.
>
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  21 +++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_devids.h   |   2 +
 > drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 156 ++++++++++++++++++
 > drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  22 +++
 > drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 > 7 files changed, 204 insertions(+)
> 
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
