From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 17:50:49 +0000
Subject: [Intel-wired-lan] [next PATCH S54 07/15] i40e: move all updates
 for	VLAN mode into i40e_sync_vsi_filters
In-Reply-To: <1478896779-13697-8-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA383C4@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S54 07/15] i40e: move all updates for
> VLAN mode into i40e_sync_vsi_filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In a similar fashion to how we handled exiting VLAN mode, move the logic in
> i40e_vsi_add_vlan into i40e_sync_vsi_filters. Extract this logic into its own
> function for ease of understanding as it will become quite complex.
> 
> The new function, i40e_correct_mac_vlan_filters() correctly updates all
> filters for when we need to enter VLAN mode, exit VLAN mode, and also
> enforces the PVID when assigned.
> 
> Call i40e_correct_mac_vlan_filters from i40e_sync_vsi_filters passing it the
> number of active VLAN filters, and the two temporary lists.
> 
> Remove the function for updating VLAN=0 filters from i40e_vsi_add_vlan.
> 
> The end result is that the logic for entering and exiting VLAN mode is in one
> location which has the most knowledge about all filters. This ensures that we
> always correctly have the non-VLAN filters assigned to
> VID=0 or VID=-1 regardless of how we ended up getting to this result.
> 
> Additionally this enforces the PVID at sync time so that we know for certain
> that an assigned PVID results in only filters with that PVID will be added to
> the firmware.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I895cee81e9c92d0a16baee38bd0ca51bbb14e372
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 214 +++++++++++++++-------
> ------
>  1 file changed, 113 insertions(+), 101 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


