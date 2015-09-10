From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 16:47:37 +0000
Subject: [Intel-wired-lan] [next PATCH S14 02/15] i40e: Make it clear
	a	parameter is never used
In-Reply-To: <1441065295-234333-3-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A615E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S14 02/15] i40e: Make it clear a
> parameter is never used
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> Flag the filter_mask parameter as __always_unused in the
> ndo_bridge_getlink function.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ifc1e99c7fb84bcbf81cf7b0ac891ad8ca956ffb2
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
