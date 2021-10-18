From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Mon, 18 Oct 2021 15:59:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/3] ice: Add infrastructure
 for mqprio support via ndo_setup_tc
In-Reply-To: <20211011192518.1867431-2-sudheer.mogilappagari@intel.com>
References: <20211011192518.1867431-1-sudheer.mogilappagari@intel.com>
 <20211011192518.1867431-2-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB36142C5F2CFF716E0E3A03AD8EBC9@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> sudheer.mogilappagari at intel.com
> Sent: Tuesday, October 12, 2021 12:55 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 1/3] ice: Add infrastructure for
> mqprio support via ndo_setup_tc
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Add infrastruture required for "ndo_setup_tc:qdisc_mqprio".
> ice_vsi_setup is modified to configure traffic classes based on mqprio data
> received from the stack. This includes low-level functions to configure
> min,max rate-limit parameters in hardware for traffic classes. Each traffic
> class gets mapped to a hardware channel (VSI) which can be individually
> configured with different banwidth parameters.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  78 +++-
>  drivers/net/ethernet/intel/ice/ice_base.c     |  31 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 201 ++++++---
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  10 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 384 +++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  15 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  68 +++-
>  drivers/net/ethernet/intel/ice/ice_sched.h    |   2 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   7 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   4 +-
>  13 files changed, 673 insertions(+), 138 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
