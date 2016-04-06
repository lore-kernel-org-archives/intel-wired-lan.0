From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 22:13:51 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 09/13] i40e: Move NVM
 variable	out of AQ struct
In-Reply-To: <1459508173-22777-10-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-10-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9AD015@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v3 next PATCH S32 09/13] i40e: Move NVM
> variable out of AQ struct
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The NVM update status info should stay collected together, not spread
> across different structs.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ic16f9e9fd79945d865bb7226184c889884585025
> ---
> Testing Hints :
> 	Compile code and run an NVM update
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h   |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c      | 12 ++++++------
>  drivers/net/ethernet/intel/i40e/i40e_type.h     |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.h |  1 -
>  drivers/net/ethernet/intel/i40evf/i40e_type.h   |  1 +
>  6 files changed, 11 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
nvmupdate works as expected
