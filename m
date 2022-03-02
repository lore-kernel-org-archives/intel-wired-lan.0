From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:41:42 +0000
Subject: [Intel-wired-lan] [net-next PATCH 24/25] ice: introduce
 ice_virtchnl.c and ice_virtchnl.h
In-Reply-To: <20220223002712.2771809-25-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-25-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629650A7BAFFA6417908DC0AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 24/25] ice: introduce
> ice_virtchnl.c and ice_virtchnl.h
> 
> Just as we moved the generic virtualization library logic into
> ice_vf_lib.c, move the virtchnl message handling into ice_virtchnl.c
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |    1 +
>  drivers/net/ethernet/intel/ice/ice_sriov.c    | 3771 -----------------
>  drivers/net/ethernet/intel/ice/ice_sriov.h    |   55 +-
>  .../intel/ice/{ice_sriov.c => ice_virtchnl.c} | 1915 +--------
>  drivers/net/ethernet/intel/ice/ice_virtchnl.h |   82 +
>  5 files changed, 89 insertions(+), 5735 deletions(-)
>  copy drivers/net/ethernet/intel/ice/{ice_sriov.c => ice_virtchnl.c} (68%)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl.h
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index c21a0aa897a5..9183d480b70b 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
