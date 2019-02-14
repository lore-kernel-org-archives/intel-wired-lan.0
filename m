From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Feb 2019 23:50:05 +0000
Subject: [Intel-wired-lan] [PATCH S11 06/16] ice: fix
 ice_remove_rule_internal vsi_list handling
In-Reply-To: <20190208205043.11975-7-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366248@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 06/16] ice: fix
> ice_remove_rule_internal vsi_list handling
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When adding multiple VLANs to the same VSI, the ice_add_vlan code will
> share the VSI list, so as not to create multiple unnecessary VSI lists.
> 
> Consider the following flow
> 
>   ice_add_vlan(hw, <VSI 0 VID 7, VSI 0 VID 8, VSI 0 VID 9>)
> 
> Where we add three VLAN filters for VIDs 7, 8, and 9, all for VSI 0.
> 
> The ice_add_vlan will create a single vsi_list and share it among all the filters.
> 
> Later, if we try to remove a VLAN,
> 
>   ice_remove_vlan(hw, <VSI 0 VID 7>)
> 
> Then the removal code will update the vsi_list and remove VSI 0 from it.
> But, since the vsi_list is shared, this breaks the list for the other users who
> reference it. We actually even free the VSI list memory, and may result in
> segmentation faults.
> 
> This is due to the way that VLAN rule share VSI lists with reference counts,
> and is caused because we call ice_rem_update_vsi_list even when the
> ref_cnt is greater than one.
> 
> To fix this, handle the case where ref_cnt is greater than one separately. In
> this case, we need to remove the associated rule without modifying the
> vsi_list, since it is currently being referenced by another rule. Instead, we
> just need to decrement the VSI list ref_cnt.
> 
> The case for handling sharing of VSI lists with multiple VSIs is not currently
> supported by this code. No such rules will be created today, and this code will
> require changes if/when such code is added.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


