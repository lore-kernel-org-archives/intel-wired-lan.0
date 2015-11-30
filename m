From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Nov 2015 18:55:51 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 03/12] i40e: properly
 delete	VF MAC filters
In-Reply-To: <1447961665-12344-4-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-4-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F964BAE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [V3: next PATCH S22 03/12] i40e: properly delete
> VF MAC filters
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The virtual channel interface was using incorrect semantics to remove MAC
> addresses, which would leave incorrect filters active when using VLANs. To
> correct this, add a new function that unconditionally removes MAC
> addresses from all VLANs, and call this function when the VF requests a MAC
> filter removal.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I69826908ae4f6c847f5bf9b32f11faa760189c74
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 36
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 +++--
>  3 files changed, 44 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, able to correctly remove VF MAC filter
