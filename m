From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 22 Feb 2022 09:40:03 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 01/11] ice: refactor
 unwind cleanup in eswitch mode
In-Reply-To: <20220216213738.3826664-2-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-2-jacob.e.keller@intel.com>
Message-ID: <MW3PR11MB4554732D42CB5EEFFB5E74AD9C3B9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Jacob Keller
>Sent: Thursday, February 17, 2022 3:07 AM
>To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
>Subject: [Intel-wired-lan] [net-next PATCH v2 01/11] ice: refactor unwind
>cleanup in eswitch mode
>
>The code for supporting eswitch mode and port representors on VFs uses an
>unwind based cleanup flow when handling errors.
>
>These flows are used to cleanup and get everything back to the state prior to
>attempting to switch from legacy to representor mode or back.
>
>The unwind iterations make sense, but complicate a plan to refactor the VF
>array structure. In the future we won't have a clean method of reversing an
>iteration of the VFs.
>
>Instead, we can change the cleanup flow to just iterate over all VF structures
>and clean up appropriately.
>
>First notice that ice_repr_add_for_all_vfs and ice_repr_rem_from_all_vfs
>have an additional step of re-assigning the VC ops. There is no good reason to
>do this outside of ice_repr_add and ice_repr_rem. It can simply be done as
>the last step of these functions.
>
>Second, make sure ice_repr_rem is safe to call on a VF which does not have a
>representor. Check if vf->repr is NULL first and exit early if so.
>
>Move ice_repr_rem_from_all_vfs above ice_repr_add_for_all_vfs so that we
>can call it from the cleanup function.
>
>In ice_eswitch.c, replace the unwind iteration with a call to
>ice_eswitch_release_reprs. This will go through all of the VFs and revert the VF
>back to the standard model without the eswitch mode.
>
>To make this safe, ensure this function checks whether or not the represent or
>has been moved. Rely on the metadata destination in
>vf->repr->dst. This must be NULL if the representor has not been moved
>to eswitch mode.
>
>Ensure that we always re-assign this value back to NULL after freeing it, and
>move the ice_eswitch_release_reprs so that it can be called from the setup
>function.
>
>With these changes, eswitch cleanup no longer uses an unwind flow that is
>problematic for the planned VF data structure change.
>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c | 63 ++++++++++----------
> drivers/net/ethernet/intel/ice/ice_repr.c    | 47 +++++++--------
> 2 files changed, 54 insertions(+), 56 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
