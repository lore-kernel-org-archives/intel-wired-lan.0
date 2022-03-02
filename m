From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 20:00:46 +0000
Subject: [Intel-wired-lan] [net-next PATCH 12/25] ice: introduce
 ice_vf_lib.c, ice_vf_lib.h, and ice_vf_lib_private.h
In-Reply-To: <20220223002712.2771809-13-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-13-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56296D3834F9947501A9AB08AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 12/25] ice: introduce ice_vf_lib.c,
> ice_vf_lib.h, and ice_vf_lib_private.h
> 
> Introduce the ice_vf_lib.c file along with the ice_vf_lib.h and
> ice_vf_lib_private.h header files.
> 
> These files will house the generic VF structures and access functions.
> Move struct ice_vf and its dependent definitions into this new header
> file.
> 
> The ice_vf_lib.c is compiled conditionally on CONFIG_PCI_IOV. Some of
> its functionality is required by all driver files. However, some of its
> functionality will only be required by other files also conditionally
> compiled based on CONFIG_PCI_IOV.
> 
> Declaring these functions used only in CONFIG_PCI_IOV files in
> ice_vf_lib.h is verbose. This is because we must provide a fallback
> implementation for each function in this header since it is included in
> files which may not be compiled with CONFIG_PCI_IOV.
> 
> Instead, introduce a new ice_vf_lib_private.h header which verifies that
> CONFIG_PCI_IOV is enabled. This header is intended to be directly
> included in .c files which are CONFIG_PCI_IOV only. Add a #error
> indication that will complain if the file ever gets included by another
> C file on a kernel with CONFIG_PCI_IOV disabled. Add a comment
> indicating the nature of the file and why it is useful.
> 
> This makes it so that we can easily define functions exposed from
> ice_vf_lib.c into other virtualization files without needing to add
> fallback implementations for every single function.
> 
> This begins the path to separate out generic code which will be reused
> by other virtualization implementations from ice_sriov.h and ice_sriov.c
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   3 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    | 509 +----------------
>  drivers/net/ethernet/intel/ice/ice_sriov.h    | 203 +------
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 519 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h   | 259 +++++++++
>  .../ethernet/intel/ice/ice_vf_lib_private.h   |  39 ++
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   1 +
>  .../ethernet/intel/ice/ice_virtchnl_fdir.h    |   1 +
>  8 files changed, 823 insertions(+), 711 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_lib.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_lib.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 816e81832b7f..c21a0aa897a5 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -34,11 +34,12 @@ ice-y := ice_main.o	\

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
