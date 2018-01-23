From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Jan 2018 22:54:59 +0000
Subject: [Intel-wired-lan] [next PATCH S86-V2 8/8] i40evf: Make VF reset
 warning message more clear
In-Reply-To: <20180122170039.14144-8-alice.michael@intel.com>
References: <20180122170039.14144-1-alice.michael@intel.com>
 <20180122170039.14144-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A133@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, January 22, 2018 9:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86-V2 8/8] i40evf: Make VF reset
> warning message more clear
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> When the PF resets the VF, the VF puts out a warning message indicating
> that the VF received a reset message from the PF.
> Make this message more clear so that we do not mistakenly think that the PF
> is undergoing a reset.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


