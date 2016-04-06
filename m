From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 21:33:28 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 08/13] i40e: Restrict VF
 poll	mode to only single function mode devices
In-Reply-To: <1459508173-22777-9-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-9-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACFEA@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v3 next PATCH S32 08/13] i40e: Restrict VF poll
> mode to only single function mode devices
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The VFs can request their queues to be set up into polling mode, rather than
> interrupt mode, which works well for supporting things like DPDK, but this
> should not be available when working in an multi-function support device.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Id36792e4e7422db8f2033336507211f68f14ff6f
> ---
> Testing Hints:
>     case 1:
> 	set up a DPDK VF in an NPAR environment
> 	the VF polling request should be failed and a message logged
>     case 2:
> 	set up a DPDK VF in an SFP environment
> 	the VF polling request should succeed
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Builds, compiles, and passes traffic
