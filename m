From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 16:21:01 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 05/12] i40e: Fix
	static	analysis tool warning
In-Reply-To: <1469646161-30024-6-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB8F8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 05/12] i40e: Fix static analysis
> tool warning
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> This patch fixes a problem where a static analysis tool generates a warning
> for "INVARIANT_CONDITION: Expression 'enabled_tc' used in the condition
> always yields the same result."
> 
> Without this patch, the driver will not pass the static analysis tool checks
> without generating warnings.
> 
> This patch fixes the problem by eliminating the irrelevant check and
> redundant assignment for the value of enabled_tc.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Change-ID: Ia7d44cb050f507df7de333e96369d322e08bf408
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No error from static analysis
