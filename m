From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 Aug 2016 15:47:30 +0000
Subject: [Intel-wired-lan] [next PATCH S44 6/6] i40e: Fix for extra
	byte	swap in tunnel setup
In-Reply-To: <1472063631-9033-7-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
 <1472063631-9033-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAB27@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, August 24, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S44 6/6] i40e: Fix for extra byte swap
> in tunnel setup
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes an issue where we were byte swapping the port parameter,
> then byte swapping it again in function execution.
> Obviously, that's unnecessary, so take it out of the function calls.
> Without this patch, the udp based tunnel configuration would not be correct.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I788d83c5bd5732170f1a81dbfa0b1ac3ca8ea5b7
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

