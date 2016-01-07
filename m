From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 19:28:33 +0000
Subject: [Intel-wired-lan] [next PATCH S26 10/12] i40e: count
	allocation	errors
In-Reply-To: <1451932392-15538-11-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-11-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E4B1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S26 10/12] i40e: count allocation
> errors
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Driver already counted allocation errors, so print them as part of the ethtool -
> S output.  Useful for debugging if your system is having trouble making
> memory available for the driver.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I83839fa86e81e6d80f03b917c88dd3ef9a64dde0
> ---
> Testing-Hints:
> Look for rx_alloc_fail andi rx_pg_alloc_fail in the ethtool -S output.
> Memory pressure or the kernel allocation failure simulator are necessary to
> get the counters to increment.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool shows added counters
