From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 19:46:22 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 04/13] i40e/i40evf: Move
 stack	var deeper
In-Reply-To: <1459508173-22777-5-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-5-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACBB4@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v3 next PATCH S32 04/13] i40e/i40evf: Move stack
> var deeper
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> A local variable could move down inside the context where it is used.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I9caba9e1eacf921037077f2665cbce83fd8e95d6
> ---
> Testing Hints : Compile test, no functional change.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver compiles normally
