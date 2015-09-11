From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:16:32 +0000
Subject: [Intel-wired-lan] [next PATCH S15 10/15] i40e/i40evf:
	remove	redundant declarations of a variable and a function
In-Reply-To: <1441315142-173025-11-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6418@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 10/15] i40e/i40evf: remove
> redundant declarations of a variable and a function
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Remove a variable declaration inside an if block hiding an existing declaration
> at the start of the function.
> 
> Also remove a forward function declaration that is no longer needed due to
> code re-organization.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I12954668b722718074949c93d74cd20eaacd93e4
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 3 ---
> drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
