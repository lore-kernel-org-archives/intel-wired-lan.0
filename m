From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 22:01:40 +0000
Subject: [Intel-wired-lan] [next PATCH S34 07/12] i40e: Fix
 uninitialized	variable
In-Reply-To: <1460542112-20166-8-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-8-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2053@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, April 13, 2016 3:08 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S34 07/12] i40e: Fix uninitialized
> variable
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> We have an uninitialized variable warning for valid_len for one case in
> validate_vf_mesg. To fix this, just initialize it to 0 at the top of the function
> and remove all of the now redundant assignments to 0 in the individual
> cases.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-Id: Iacbd97f4c521ed8d662eef803a598d8707708cfd
> ---
> Testing Hints: Should net no functional change - make sure nothing broke.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
