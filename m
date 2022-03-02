From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:05:46 +0000
Subject: [Intel-wired-lan] [net-next PATCH 01/25] ice: rename
 ice_sriov.c to ice_vf_mbx.c
In-Reply-To: <20220223002712.2771809-2-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-2-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629541F17EBDF2F2DD00858AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 01/25] ice: rename ice_sriov.c to
> ice_vf_mbx.c
> 
> The ice_sriov.c file primarily contains code which handles the logic for
> mailbox overflow detection and some other utility functions related to the
> virtualization mailbox.
> 
> The bulk of the SR-IOV implementation is actually found in ice_virtchnl_pf.c,
> and this file isn't strictly SR-IOV specific.
> 
> In the future, the ice driver will support an additional virtualization scheme
> known as Scalable IOV, and the code in this file will be used for this
> alternative implementation.
> 
> Rename this file (and its associated header) to ice_vf_mbx.c, so that we can
> later re-use the ice_sriov.c file as the SR-IOV specific file.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile                     | 2 +-
>  drivers/net/ethernet/intel/ice/ice.h                        | 2 +-
>  .../net/ethernet/intel/ice/{ice_sriov.c => ice_vf_mbx.c}    | 2 +-
>  .../net/ethernet/intel/ice/{ice_sriov.h => ice_vf_mbx.h}    | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)  rename
> drivers/net/ethernet/intel/ice/{ice_sriov.c => ice_vf_mbx.c} (99%)  rename
> drivers/net/ethernet/intel/ice/{ice_sriov.h => ice_vf_mbx.h} (95%)
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 44b8464b7663..451098e25023 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -36,7 +36,7 @@ ice-y := ice_main.o	\

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
