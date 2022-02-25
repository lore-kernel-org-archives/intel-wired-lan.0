From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:21:39 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 04/11] ice: move
 clear_malvf call in ice_free_vfs
In-Reply-To: <20220216213738.3826664-5-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-5-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629DE227C9D6FFCAC639BBAAB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH v2 04/11] ice: move clear_malvf
> call in ice_free_vfs
> 
> The ice_mbx_clear_malvf function is used to clear the indication and count of
> how many times a VF was detected as malicious. During ice_free_vfs, we use
> this function to ensure that all removed VFs are reset to a clean state.
> 
> The call currently is done at the end of ice_free_vfs() using a tmp value to
> iterate over all of the entries in the bitmap.
> 
> This separate iteration using tmp is problematic for a planned refactor of the
> VF array data structure. To avoid this, lets move the call slightly higher into
> the function inside the loop where we teardown all of the VFs. This avoids
> one use of the tmp value used for iteration.
> We'll fix the other user in a future change.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 44037d569755..c469b32f665b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -536,6 +536,12 @@ void ice_free_vfs(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
