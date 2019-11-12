From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:34:00 +0000
Subject: [Intel-wired-lan] [PATCH S33 08/15] ice: Refactor removal of
 VLAN promiscuous rules
In-Reply-To: <20191108142331.10221-8-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-8-anthony.l.nguyen@intel.com>
Message-ID: <a3d470335bfc471f98a6335ebe75e85a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 08/15] ice: Refactor removal of VLAN
> promiscuous rules
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently ice_clear_vsi_promisc() detects if the VLAN ID sent is not 0 and
> sets the recipe_id to ICE_SW_LKUP_PROMISC_VLAN in that case and
> ICE_SW_LKUP_PROMISC if the VLAN_ID is 0. However this doesn't allow
> VLAN
> 0 promiscuous rules to be removed, but they can be added. Fix this by
> checking if the promisc_mask contains ICE_PROMISC_VLAN_RX or
> ICE_PROMISC_VLAN_TX. This change was made to match what is being done
> for ice_set_vsi_promisc().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


