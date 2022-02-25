From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:22:37 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 06/11] ice: remove checks
 in ice_vc_send_msg_to_vf
In-Reply-To: <20220216213738.3826664-7-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-7-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629BBA621835DE4496BE0E9AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH v2 06/11] ice: remove checks in
> ice_vc_send_msg_to_vf
> 
> The ice_vc_send_msg_to_vf function is used by the PF to send a response to
> a VF. This function has overzealous checks to ensure its not passed a NULL VF
> pointer and to ensure that the passed in struct ice_vf has a valid vf_id sub-
> member.
> 
> These checks have existed since commit 1071a8358a28 ("ice: Implement
> virtchnl commands for AVF support") and function as simple sanity checks.
> 
> We are planning to refactor the ice driver to use a hash table along with
> appropriate locks in a future refactor. This change will modify how the
> ice_validate_vf_id function works. Instead of a simple >= check to ensure
> the VF ID is between some range, it will check the hash table to see if the
> specified VF ID is actually in the table. This requires that the function properly
> lock the table to prevent race conditions.
> 
> The checks may seem ok at first glance, but they don't really provide much
> benefit.
> 
> In order for ice_vc_send_msg_to_vf to have these checks fail, the callers
> must either (1) pass NULL as the VF, (2) construct an invalid VF pointer
> manually, or (3) be using a VF pointer which becomes invalid after they
> obtain it properly using ice_get_vf_by_id.
> 
> For (1), a cursory glance over callers of ice_vc_send_msg_to_vf can show
> that in most cases the functions already operate assuming their VF pointer is
> valid, such as by derferencing vf->pf or other members.
> 
> They obtain the VF pointer by accessing the VF array using the VF ID, which
> can never produce a NULL value (since its a simple address operation on the
> array it will not be NULL.
> 
> The sole exception for (1) is that ice_vc_process_vf_msg will forward a NULL
> VF pointer to this function as part of its goto error handler logic. This requires
> some minor cleanup to simply exit immediately when an invalid VF ID is
> detected (Rather than use the same error flow as the rest of the function).
> 
> For (2), it is unexpected for a flow to construct a VF pointer manually instead
> of accessing the VF array. Defending against this is likely to just hide bad
> programming.
> 
> For (3), it is definitely true that VF pointers could become invalid, for example
> if a thread is processing a VF message while the VF gets removed. However,
> the correct solution is not to add additional checks like this which do not
> guarantee to prevent the race. Instead we plan to solve the root of the
> problem by preventing the possibility entirely.
> 
> This solution will require the change to a hash table with proper locking and
> reference counts of the VF structures. When this is done, ice_validate_vf_id
> will require locking of the hash table. This will be problematic because all of
> the callers of ice_vc_send_msg_to_vf will already have to take the lock to
> obtain the VF pointer anyways. With a mutex, this leads to a double lock that
> could hang the kernel thread.
> 
> Avoid this by removing the checks which don't provide much value, so that
> we can safely add the necessary protections properly.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 7ab4e7d4cfb7..6351af58f74e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -2206,13 +2206,7 @@ ice_vc_send_msg_to_vf(struct ice_vf *vf, u32

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
