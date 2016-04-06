From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 22:15:04 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 11/13] i40e: Move nvm
 event	wait check to nvm code
In-Reply-To: <1459508173-22777-12-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-12-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9AD025@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v3 next PATCH S32 11/13] i40e: Move nvm event
> wait check to nvm code
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The logic that checks AQ events for NVM done events is better kept in nvm.c
> with the rest of the nvmupdate handling code.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I2ea58980df8ecaa3726b28a37bff3dfcb8df03dc
> ---
> Testing Hints:
> 	Compile code and run nvmupdate
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c    | 31 +-----------------------
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c       | 31
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  1 +
>  3 files changed, 33 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
nvmupdate works as expected
