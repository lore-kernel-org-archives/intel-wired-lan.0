From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:40:55 +0000
Subject: [Intel-wired-lan] [net-next PATCH 25/25] ice: remove PF pointer
 from ice_check_vf_init
In-Reply-To: <20220223002712.2771809-26-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-26-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56298202A99227B1133B1457AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 25/25] ice: remove PF pointer
> from ice_check_vf_init
> 
> The ice_check_vf_init function takes both a PF and a VF pointer. Every caller
> looks up the PF pointer from the VF structure. Some callers only use of the
> PF pointer is call this function. Move the lookup inside ice_check_vf_init and
> drop the unnecessary argument.
> 
> Cleanup the callers to drop the now unnecessary local variables. In particular,
> replace the local PF pointer with a HW structure pointer in
> ice_vc_get_vf_res_msg which simplifies a few accesses to the HW structure
> in that function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c      | 16 +++++++---------
>  .../net/ethernet/intel/ice/ice_vf_lib_private.h  |  2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c    | 12 ++++++------
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index c584f5123ba7..6578059d9479 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -174,15 +174,12 @@ static void ice_wait_on_vf_reset(struct ice_vf *vf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
