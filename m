From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:05:22 +0000
Subject: [Intel-wired-lan] [net-next PATCH 02/25] ice: rename
 ice_virtchnl_pf.c to ice_sriov.c
In-Reply-To: <20220223002712.2771809-3-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-3-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56290B3CD3E60E4918AB0178AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 23, 2022 1:27 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH 02/25] ice: rename
> ice_virtchnl_pf.c to ice_sriov.c
> 
> The ice_virtchnl_pf.c and ice_virtchnl_pf.h files are where most of the code
> for implementing Single Root IOV virtualization resides. This code includes
> support for bringing up and tearing down VFs, hooks into the kernel SR-IOV
> netdev operations, and for handling virtchnl messages from VFs.
> 
> In the future, we plan to support Scalable IOV in addition to Single Root IOV
> as an alternative virtualization scheme. This implementation will re-use some
> but not all of the code in ice_virtchnl_pf.c
> 
> To prepare for this future, we want to refactor and split up the code in
> ice_virtchnl_pf.c into the following scheme:
> 
>  * ice_vf_lib.[ch]
> 
>    Basic VF structures and accessors. This is where scheme-independent
>    code will reside.
> 
>  * ice_virtchnl.[ch]
> 
>    Virtchnl message handling. This is where the bulk of the logic for
>    processing messages from VFs using the virtchnl messaging scheme will
>    reside. This is separated from ice_vf_lib.c because it is distinct
>    and has a bulk of the processing code.
> 
>  * ice_sriov.[ch]
> 
>    Single Root IOV implementation, including initialization and the
>    routines for interacting with SR-IOV based netdev operations.
> 
>  * (future) ice_siov.[ch]
> 
>    Scalable IOV implementation.
> 
> As a first step, lets assume that all of the code in ice_virtchnl_pf.[ch] is for
> Single Root IOV. Rename this file to ice_sriov.c and its header to ice_sriov.h
> 
> Future changes will further split out the code in these files following the plan
> outlined here.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile                     | 2 +-
>  drivers/net/ethernet/intel/ice/ice.h                        | 2 +-
>  drivers/net/ethernet/intel/ice/ice_base.c                   | 2 +-
>  drivers/net/ethernet/intel/ice/ice_repr.c                   | 2 +-
>  .../ethernet/intel/ice/{ice_virtchnl_pf.c => ice_sriov.c}   | 0
>  .../ethernet/intel/ice/{ice_virtchnl_pf.h => ice_sriov.h}   | 6 +++---
>  drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c        | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)  rename
> drivers/net/ethernet/intel/ice/{ice_virtchnl_pf.c => ice_sriov.c} (100%)
> rename drivers/net/ethernet/intel/ice/{ice_virtchnl_pf.h => ice_sriov.h}
> (99%)
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 451098e25023..816e81832b7f 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -38,7 +38,7 @@ ice-$(CONFIG_PCI_IOV) +=	\
>  	ice_virtchnl_fdir.o	\
>  	ice_vf_mbx.o		\
>  	ice_vf_vsi_vlan_ops.o	\
> -	ice_virtchnl_pf.o
> +	ice_sriov.o
>  ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o
>  ice-$(CONFIG_TTY) += ice_gnss.o
>  ice-$(CONFIG_DCB) += ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o diff --git
> a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 6c41edd99410..0fd15b45ce23 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -66,7 +66,7 @@

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
