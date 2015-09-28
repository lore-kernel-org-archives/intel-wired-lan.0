From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Sep 2015 18:04:16 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix RS bit update in Tx path
 and	disable force WB workaround
In-Reply-To: <1443230773-174806-1-git-send-email-anjali.singhai@intel.com>
References: <1443230773-174806-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D87@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Friday, September 25, 2015 6:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix RS bit update in Tx path and
> disable force WB workaround
> 
> This patch fixes the issue of forcing WB too often causing us to not benefit
> from NAPI.
> 
> Without this patch we were forcing WB/arming interrupt too often taking
> away the benefits of NAPI and causing a performance impact.
> 
> With this patch we disable force WB in the clean routine for X710 and XL710
> adapters. X722 adapters do not enable interrupt to force a WB and benefit
> from WB_ON_ITR and hence force WB is left enabled for those adapters.
> For XL710 and X710 adapters if we have less than 4 packets pending a
> software Interrupt triggered from service task will force a WB.
> 
> This patch also changes the conditions for setting RS bit as described in code
> comments. This optimizes when the HW does a tail bump amd when it does a
> WB. It also optimizes when we do a wmb.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 126 ++++++++++++++++++---
> -------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   2 +
>  2 files changed, 86 insertions(+), 42 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
