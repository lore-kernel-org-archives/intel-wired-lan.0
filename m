From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 19:47:13 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 05/13] i40e/i40evf:
	Drop	unused tx_ring argument
In-Reply-To: <1459508173-22777-6-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-6-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACBC4@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v3 next PATCH S32 05/13] i40e/i40evf: Drop
> unused tx_ring argument
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Some of the tx_ring arguments can be deleted since they are not used.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I99275b0f191d7f63ec2f05061919904940c36f31
> ---
> Testing Hints: Compile test, no functional change.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 6 ++----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver compiles normally
