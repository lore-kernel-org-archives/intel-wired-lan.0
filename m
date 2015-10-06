From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Oct 2015 21:22:16 +0000
Subject: [Intel-wired-lan] [next PATCH S18 3/8] i40e: Fix VEB/VEPA
 bridge	mode mismatch issue
In-Reply-To: <1443724661-92168-4-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B3836@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G
> Subject: [Intel-wired-lan] [next PATCH S18 3/8] i40e: Fix VEB/VEPA bridge
> mode mismatch issue
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Fix i40e_is_vsi_uplink_mode_veb to check if bridge is actually in VEB mode
> before allowing LB in the add vsi routine, instead of unconditionally returning
> VEB bridge mode.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Change-ID: I162397b1bdd02367735fe9baaeb51465be2a3ce9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, "Switch no longer goes to VEB mode but stays in VEPA mode. 
No kernel crash. "
