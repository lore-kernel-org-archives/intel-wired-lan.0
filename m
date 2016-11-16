From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Nov 2016 19:21:51 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 03/15] i40e: Pass unknown
 PHY	type for unknown PHYs
In-Reply-To: <1478639119-14656-4-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA36D1E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S52-V2 03/15] i40e: Pass unknown
> PHY type for unknown PHYs
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> The PHY type value for unrecognized PHYs and cables was changed based on
> firmware version number. Newer hardware use lower firmware version
> numbers and this was causing some PHYs to be identified as type 0x16
> instead of 0xe (unknown).
> 
> Without this patch, newer card will incorrectly identify unknown PHYs and
> cables.
> 
> This change adds hardware type to the check for firmware version so the PHY
> type is reported correctly.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: I0723cbfd263c76fc73ff1a5275d1639051376c9a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


