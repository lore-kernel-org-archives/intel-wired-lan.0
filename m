From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jan 2016 21:56:43 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 04/15] i40e: add VEB
	stat	control and remove L2 cloud filter
In-Reply-To: <1452732712-12248-5-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-5-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F980941@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 04/15] i40e: add VEB stat
> control and remove L2 cloud filter
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> With the latest firmware, statistics gathering can now be enabled and
> disabled in the HW switch, so we need to add a parameter to allow the driver
> to set it as desired.  At the same time, the L2 cloud filtering parameter has
> been removed as it was never used.
> 
> Older drivers working with the newer firmware and newer drivers working
> with older firmware will not run into problems with these bits as the defaults
> are reasonable and there is no overlap in the bit definitions.
> Also, newer drivers will be forced to update because of the change in
> function call parameters, a reminder that the functionality exists.
> 
> Also update copyright year.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I9acb9160b892ca3146f2f11a88fdcd86be3cadcc
> ---
> Testing Hints: Testing hints will be driver dependent, see the related base
> driver changes.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 11 ++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_main.c      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  6 +++---
>  3 files changed, 10 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
