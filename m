From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 17:26:28 +0000
Subject: [Intel-wired-lan] [next PATCH S25 06/16] i40e: Store
 lan_vsi_idx	and lan_vsi_id in the right size
In-Reply-To: <1450901156-30904-7-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-7-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B555@ORSMSX104.amr.corp.intel.com>
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
> Cc: Maharajan, Pandi <pandi.maharajan@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S25 06/16] i40e: Store lan_vsi_idx and
> lan_vsi_id in the right size
> 
> From: Pandi Maharajan <pandi.maharajan@intel.com>
> 
> lan_vsi_idx and lan_vsi_id are assigned to u16 data sized variables but
> declared in u8. This patch fixes the width of the datatype.
> 
> Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> Change-ID: If4bcbcc7d32f2b287c51cb33d17879691258dce2
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
