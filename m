From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 20:45:51 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 06/10] i40e: prevent
 service	task from running while we're suspended
In-Reply-To: <20170714132709.52657-6-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2782@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S77-V3 06/10] i40e: prevent service
> task from running while we're suspended
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Although the service task does check the suspended status before running, it
> might already be part way through running when we go to suspend. Lets
> ensure that the service task is stopped and will not be restarted again until
> we finish resuming. This ensures that service task code does not cause
> strange interactions with the suspend/resume handlers.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


