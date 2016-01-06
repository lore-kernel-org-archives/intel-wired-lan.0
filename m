From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Jan 2016 22:39:56 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S23 08/13] i40e: define
 function	capabilities in only one place
In-Reply-To: <1449776331-8330-1-git-send-email-joshua.a.hay@intel.com>
References: <1449776331-8330-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E278@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Thursday, December 10, 2015 11:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S23 08/13] i40e: define function
> capabilities in only one place
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The device capabilities were defined in two places, and neither had all the
> definitions.  It really belongs with the AQ API definition, so this patch
> removes the other set of definitions and fills out the missing item.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I273ba7d79a476cd11d2e0ca5825fec1716740de2
> ---
> V2: remove second signed-off-by
> 
> Testing Hints: Apply and compile cleanly
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 85 +++++++-------------
> --
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  1 +
>  3 files changed, 30 insertions(+), 57 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
