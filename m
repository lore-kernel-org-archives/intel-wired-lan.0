From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 3 Oct 2016 18:53:01 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix bit logic error in failure
 case
In-Reply-To: <1475224581-121904-1-git-send-email-david.m.ertman@intel.com>
References: <1475224581-121904-1-git-send-email-david.m.ertman@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F663@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Dave Ertman
> Sent: Friday, September 30, 2016 1:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix bit logic error in failure case
> 
> Patch a036244c0686 "i40e: Fix kernel panic on enable/disable LLDP"
> introduced an error in bit logic.
> 
> Originally this bit manipulation was meant to clear two bits to indicate that
> DCB was not enabled or capable. An "&" was incorrectly used instead of an
> "|" bit operator to combine the two bitmasks into one.  This also created a
> static checker error since the resultant code was a no-op.
> 
> This patch fixes the error by using the correct bit-wise operator.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Found-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

