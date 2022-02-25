From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:21:11 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 03/11] ice: pass num_vfs
 to ice_set_per_vf_res()
In-Reply-To: <20220216213738.3826664-4-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-4-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629CB1AB767EC3524887DE2AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH v2 03/11] ice: pass num_vfs to
> ice_set_per_vf_res()
> 
> We are planning to replace the simple array structure tracking VFs with a
> hash table. This change will also remove the "num_alloc_vfs" variable.
> 
> Instead, new access functions to use the hash table as the source of truth will
> be introduced. These will generally be equivalent to existing checks, except
> during VF initialization.
> 
> Specifically, ice_set_per_vf_res() cannot use the hash table as it will be
> operating prior to VF structures being inserted into the hash table.
> 
> Instead of using pf->num_alloc_vfs, simply pass the num_vfs value in from
> the caller.
> 
> Note that a sub-function of ice_set_per_vf_res, ice_determine_res, also
> implicitly depends on pf->num_alloc_vfs. Replace ice_determine_res with a
> simpler inline implementation based on rounddown_pow_of_two. Note that
> we must explicitly check that the argument is non-zero since it does not play
> well with zero as a value.
> 
> Instead of using the function and while loop, simply calculate the number of
> queues we have available by dividing by num_vfs. Check if the desired
> queues are available. If not, round down to the nearest power of
> 2 that fits within our available queues.
> 
> This matches the behavior of ice_determine_res but is easier to follow as
> simple in-line logic. Remove ice_determine_res entirely.
> 
> With this change, we no longer depend on the pf->num_alloc_vfs during the
> initialization phase of VFs. This will allow us to safely remove it in a future
> planned refactor of the VF data structures.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 87 ++++++-------------
>  1 file changed, 26 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index d86d47b8fee2..44037d569755 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -1069,45 +1069,6 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
