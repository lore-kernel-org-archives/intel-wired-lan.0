From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Oct 2016 20:41:51 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 09/15] i40e: fix mac
 filters	when removing vlans
In-Reply-To: <1475685046-16900-10-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FAF3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S49-V2 09/15] i40e: fix mac filters
> when removing vlans
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Currently there exists a bug where adding at least one VLAN and then
> removing all VLANs leaves the mac filters for the VSI with an incorrect value
> for 'vid' which indicates the mac filter's vlan status.
> 
> The current implementation for handling the removal of VLANs is wrong for a
> couple reasons. The first is that when i40e_vsi_kill_vlan iterates through the
> mac filters, it fails to account for the mac filter status; i.e. it's not accomdating
> for filters that are about to be deleted. The second problem is that mac filters
> can be deleted in other places (specifically i40e_set_rx_mode). Thus if it
> occurs that all the vlan mac filters get deleted we need to switch out of vlan
> mode, but the code path through i40e_vsi_kill_vlan has already been
> executed and we're now stuck in vlan mode.
> 
> This patch fixes the issue by removing the check from i40e_vsi_kill_vlan and
> puts the check instead in i40e_sync_vsi_filters where we're guaranteed to
> see all filter deletions and can properly detect when we need to switch out
> of vlan mode.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: Ib38fe6034b356eee9a0e20b8a9eeed5ff2debcd9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 120 +++++++++++++++++----
> -------
>  1 file changed, 72 insertions(+), 48 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


