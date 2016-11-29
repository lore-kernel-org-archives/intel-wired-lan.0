From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 29 Nov 2016 20:33:28 +0000
Subject: [Intel-wired-lan] [next PATCH S54 06/15] i40e:
	use	(add|rm)_vlan_all_mac helper functions when changing PVID
In-Reply-To: <1478896779-13697-7-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38D1E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 06/15] i40e: use
> (add|rm)_vlan_all_mac helper functions when changing PVID
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The current flow for adding or updating the PVID for a VF uses
> i40e_vsi_add_vlan and i40e_vsi_kill_vlan which each take, then release the
> hash lock. In addition the two functions also must take special care that they
> do not perform VLAN mode changes as this will make the code in
> i40e_ndo_set_vf_port_vlan behave incorrectly.
> 
> Fix these issues by using the new helper functions i40e_add_vlan_all_mac
> and i40e_rm_vlan_all_mac which expect the hash lock to already be taken.
> Additionally these functions do not perform any state updates in regards to
> vlan mode, so they are safe to use in the PVID update flow.
> 
> It should be noted that we don't need the VLAN mode update code here,
> because there are only a few flows here.
> 
> (a) we're adding a new PVID
>   In this case, if we already had VLAN filters the VSI is knocked
>   offline so we don't need to worry about pre-existing VLAN filters
> 
> (b) we're replacing an existing PVID
>   In this case, we can't have any VLAN filters except those with the old
>   PVID which we already take care of manually.
> 
> (c) we're removing an existing PVID
>   Similarly to above, we can't have any existing VLAN filters except
>   those with the old PVID which we already take care of correctly.
> 
> Because of this, we do not need (or even want) the special accounting done
> in i40e_vsi_add_vlan, so use of the helpers is a saner alternative.
> It also opens the door for a future patch which will refactor the flow of
> i40e_vsi_add_vlan now that it is not needed in this function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ia841f63da94e12b106f41cf7d28ce8ce92f2ad99
> ---
> Testing-hints:
>   Ensure that adding and removing PVID for a VF works as expected, and
>   that the PVID is enforced correctly.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h             |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 43 ++++++++++++++---
> -----
>  3 files changed, 32 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


