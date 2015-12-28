From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 18:00:57 +0000
Subject: [Intel-wired-lan] [next PATCH S25 13/16] i40e: add netdev info
 to	vsi dump
In-Reply-To: <1450901156-30904-14-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-14-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B5B8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 13/16] i40e: add netdev info to vsi
> dump
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add a few more bits of netdev data into the debugfs output for dump vsi.
> For now, we'll add the features, hw_features, vlan_features, and flags
> bitflags and the state. More could be added later if needed.
> 
> Also, tweak a couple nearby output lines for output readability.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Reviewed-by: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Reviewed-by: Wyborny, Carolyn <carolyn.wyborny@intel.com>
> Change-ID: I9fb5a9da75c9ad7679498ce9ac3ba24d065ddd2e
> ---
> Testing-Hints:
> Do a "dump vsi" in debugfs and see the new prints in the output.
> 
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 24 ++++++++++++++++---
> -----
>  1 file changed, 16 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, vsi dump shows new info
