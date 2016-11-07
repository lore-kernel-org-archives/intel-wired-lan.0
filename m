From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 7 Nov 2016 16:42:57 +0000
Subject: [Intel-wired-lan] [next PATCH S52 02/11] i40e: Remove
 unreachable	code
In-Reply-To: <1478280968-8098-3-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
 <1478280968-8098-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA2ACDA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 04, 2016 10:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S52 02/11] i40e: Remove unreachable
> code
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> The code at the end of i40e_read_phy_register_clause22() contained
> unreachable code and redundant control statements.
> 
> This change removes the unreachable code. And deletes the redundant goto
> statement and if statement.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: I713032b1585396f40f903cbcfdea987abd874400
> ---
> Testing Hints:
>     Found by static analysis. Test by code inspection.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


