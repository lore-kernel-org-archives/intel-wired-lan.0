From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 4 Aug 2015 22:24:39 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Fix tight loop
 implementation	of systime read algorithm
In-Reply-To: <eb0fc1b6ebdfe79027886fbf2f64f985a413614d.1437312332.git.raanan.avargil@intel.com>
References: <eb0fc1b6ebdfe79027886fbf2f64f985a413614d.1437312332.git.raanan.avargil@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81ADF47A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Raanan Avargil
> Sent: Sunday, July 19, 2015 6:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Fix tight loop
> implementation of systime read algorithm
> 
> Change the algorithm. Read systimel twice and check for overflow.
> If there was no overflow, use the first value.
> If there was an overflow, read systimeh again and use the second systimel
> value.
> 
> Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 29 +++++++++++++++++++------
> ----
>  1 file changed, 19 insertions(+), 10 deletions(-)
This triggers a checkpatch warning for a long comment:
-------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#8:
If there was an overflow, read systimeh again and use the second systimel value.

WARNING: line over 80 characters
#49: FILE: drivers/net/ethernet/intel/e1000e/netdev.c:4299:
+               /* There was an overflow, read again SYSTIMH, and use systimel_2 */

total: 0 errors, 2 warnings, 0 checks, 37 lines checked

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
-------------------------------------------
Aside from cosmetics...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
