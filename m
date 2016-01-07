From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 19:20:15 +0000
Subject: [Intel-wired-lan] [next PATCH S26 08/12] i40e: negate phy int
 mask	bits
In-Reply-To: <1451932392-15538-9-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-9-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E491@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 08/12] i40e: negate phy int mask
> bits
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The phy interrupt mask bits mask out the events we don't want, so we need
> to negate the bitmask of events we want.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I273244da5a8d285b6abc84fd68a90f1e6fa0393e
> ---
> Testing Hints:
> The software will not be notified that an empty module has been placed into
> the cage, and link has not been established.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver not notified when empty module inserted
