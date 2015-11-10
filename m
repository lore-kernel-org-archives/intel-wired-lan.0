From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 21:00:29 +0000
Subject: [Intel-wired-lan] [next PATCH S21 10/14] i40e:
	remove	CONFIG_I40E_VXLAN
In-Reply-To: <1446852372-25480-11-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-11-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1F38@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 10/14] i40e: remove
> CONFIG_I40E_VXLAN
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Instead of having our own custom symbol, we can just rely on whether or
> not the kernel has the feature enabled.
> 
> In this case use IS_ENABLED(CONFIG_VXLAN) in order to handle built-in or
> module in the current BKM way.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I5890fbb518ff8ed6bb07c3362fb0a8a829f9b241
> ---
>  drivers/net/ethernet/intel/Kconfig          | 11 -----------
>  drivers/net/ethernet/intel/i40e/i40e.h      |  4 +---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
>  3 files changed, 7 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes altered by subesquent patch
