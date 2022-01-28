From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Fri, 28 Jan 2022 23:21:46 +0000
Subject: [Intel-wired-lan] [PATCH v4 intel-next] ice: add TTY for GNSS
 module for E810T device
In-Reply-To: <20211214122759.450794-1-karol.kolacinski@intel.com>
References: <20211214122759.450794-1-karol.kolacinski@intel.com>
Message-ID: <CO1PR11MB5028AE8200944E2A94879214A0229@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karol Kolacinski
> Sent: Tuesday, December 14, 2021 4:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mishra, Sudhansu Sekhar <sudhansu.mishra@intel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v4 intel-next] ice: add TTY for GNSS module for E810T device
>
> Add a new ice_gnss.c file for holding the basic GNSS module functions.
> If the device supports GNSS module, call the new ice_gnss_init and ice_gnss_release functions where appropriate. 
>
> Implement basic functionality for reading the data from GNSS module using TTY device.
>
> Add I2C read AQ command. It is now required for controlling the external physical connectors via external I2C port expander on E810-T adapters.
>
> Future changes will introduce write functionality.
>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Sudhansu Sekhar Mishra <sudhansu.mishra@intel.com>
> ---
> V1 -> V2: Added CONFIG_TTY dependency
> V2 -> V3: Removed unnecessary & on pf->hw pointer check
> V3 -> V4: Removed pf->hw pointer check
>
> drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice.h          |   6 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  21 +
> drivers/net/ethernet/intel/ice/ice_common.c   |  53 +++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
>  drivers/net/ethernet/intel/ice/ice_gnss.c     | 376 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_gnss.h     |  51 +++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  11 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  31 ++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   7 +
>  11 files changed, 564 insertions(+), 1 deletion(-)  create mode 100644 drivers/net/ethernet/intel/ice/ice_gnss.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_gnss.h
>
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
