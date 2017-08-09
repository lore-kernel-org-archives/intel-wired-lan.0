From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Aug 2017 22:15:02 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V6 04/12] i40e: don't
	hold	spinlock while resetting VF
In-Reply-To: <20170807142839.60975-5-alice.michael@intel.com>
References: <20170807142839.60975-1-alice.michael@intel.com>
 <20170807142839.60975-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E8FCBE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 7, 2017 7:29 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S78-V6 04/12] i40e: don't hold spinlock
> while resetting VF
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When we refactored handling of the PVID in commit 9af52f60b2d9
> ("i40e: use (add|rm)_vlan_all_mac helper functions when changing PVID")
> we introduced a scheduling while atomic regression.
> 
> This occurred because we now held the spinlock across a call to
> i40e_reset_vf(), which results in a usleep_range() call that triggers a
> scheduling while atomic bug. This was rare as it only occurred if the user
> configured a VLAN on a VF and also attempted to reconfigure the VF from
> the host system with a port VLAN.
> 
> We do need to hold the lock while calling i40e_is_vsi_in_vlan(), but we
> should not be holding it while we reset the VF.
> 
> We'll fix this by introducing a separate helper function i40e_vsi_has_vlans
> which checks whether we have a PVID and whether the VSI has configured
> VLANs. This helper function will manage its own need for the
> mac_filter_hash_lock.
> 
> Then, we can move the acquiring of the spinlock until after we reset the VF,
> which ensures that we do not sleep while holding the lock.
> 
> Using a separate function like this makes the code more clear and is easier to
> read than attempting to release and re-acquire the spinlock when we reset
> the VF.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 36
> +++++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


