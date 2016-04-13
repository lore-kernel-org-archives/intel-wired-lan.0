From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Apr 2016 18:00:13 +0000
Subject: [Intel-wired-lan] [next PATCH S33 09/13] i40e: Remove zero check
In-Reply-To: <1460475052-6348-10-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-10-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0771@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 09/13] i40e: Remove zero check
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> A mirror rule ID may be zero so do not return invalid parameter when the
> user passes in a zero value for a rule ID.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: I261b8c24725ce2c6ed32f859da81093dfcbe2970
> ---
> Testing Hints : Ensure code compiles correctly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver compiles correctly
