From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 19:44:26 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 02/13] i40e: Leave
 debug_mask	cleared at init
In-Reply-To: <1459508173-22777-3-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-3-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACB94@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Friday, April 01, 2016 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v3 next PATCH S32 02/13] i40e: Leave debug_mask
> cleared at init
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Don't set our internal debug_mask at startup unless we get specific signal to
> from the debug module parameter.
> 
> This should take care of the issue with all the device capabilities getting
> printed even when we hadn't asked for the debug info.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I7fbc6bd8b11ed9b0631ec018ff36015a04100b6c
> ---
> Testing Hints:
> 	Force a PFR and see that the extra debug message don't show up
> 
> 	enable debug with
> 		ethtool -i <ethX> msglvl 0xf0000001
> 	then force a PFR, and see that the debug message *do* show up
> 
> 	disable debug with
> 		ethtool -i <ethX> msglvl 0xf0000000
> 	then force a PFR, and see that the debug message do *not* show up
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Debug messages only show after debug mode is enabled
