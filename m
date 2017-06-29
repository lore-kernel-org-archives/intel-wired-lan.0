From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Jun 2017 20:54:44 +0000
Subject: [Intel-wired-lan] [next PATCH S74-V2 10/10] i40e: move check
 for	avoiding VID=0 filters into i40e_vsi_add_vlan
In-Reply-To: <20170623082451.32671-10-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
 <20170623082451.32671-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC1EC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, June 23, 2017 1:25 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S74-V2 10/10] i40e: move check for
> avoiding VID=0 filters into i40e_vsi_add_vlan
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In i40e_vsi_add_vlan we treat attempting to add VID=0 as an error, because
> it does not do what the caller might expect. We already special case VID=0 in
> i40e_vlan_rx_add_vid so that we avoid this error when adding the VLAN.
> 
> This special casing is necessary so that we do not add the VLAN=0 filter since
> we don't want to stop receiving untagged traffic. Unfortunately, not all
> callers of i40e_vsi_add_vlan are aware of this, including when we add VLANs
> from a VF device.
> 
> Rather than special casing every single caller of i40e_vsi_add_vlan, lets just
> move this check internally. This makes the code simpler because the caller
> does not need to be aware of how VLAN=0 is special, and we don't forget to
> add this check in new places.
> 
> This fixes a harmless error message displaying when adding a VLAN from
> within a VF. The message was meaningless but there is no reason to confuse
> end users and system administrators, and this is now avoided.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


