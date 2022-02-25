From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:24:16 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 09/11] ice: factor VF
 variables to separate structure
In-Reply-To: <20220216213738.3826664-10-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-10-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629895FDF57927F13EF14B7AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 16, 2022 10:38 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH v2 09/11] ice: factor VF variables
> to separate structure
> 
> We maintain a number of values for VFs within the ice_pf structure. This
> includes the VF table, the number of allocated VFs, the maximum number of
> supported SR-IOV VFs, the number of queue pairs per VF, the number of
> MSI-X vectors per VF, and a bitmap of the VFs with detected MDD events.
> 
> We're about to add a few more variables to this list. Clean this up first by
> extracting these members out into a new ice_vfs structure defined in
> ice_virtchnl_pf.h
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          | 10 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  | 20 +++-
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  8 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 94 ++++++++++---------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  | 15 ++-
>  7 files changed, 83 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 9041b4428af0..571396eac77c 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -543,15 +543,7 @@ struct ice_pf {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
