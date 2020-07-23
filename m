From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:25:46 +0000
Subject: [Intel-wired-lan] [PATCH S49 04/15] ice: Add advanced power
 mgmt for WoL
In-Reply-To: <20200709161614.61098-4-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-4-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145DE26B4D5A5E64FE103208C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, July 9, 2020 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S49 04/15] ice: Add advanced power mgmt
> for WoL
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Adds callbacks needed to support advanced power management for Wake
> on LAN.
> Also make ice_pf_state_is_nominal function available for all configurations
> not just CONFIG_PCI_IOV.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   3 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  56 +++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   9 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  24 ++
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 363 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |   3 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |   1 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  25 --
>  10 files changed, 458 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


