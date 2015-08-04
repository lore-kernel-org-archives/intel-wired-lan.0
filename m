From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 4 Aug 2015 22:37:34 +0000
Subject: [Intel-wired-lan] [PATCH] net: igb: implement high
	frequency	periodic output signals
In-Reply-To: <1437688770-7354-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1437688770-7354-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81ADF4A8@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, July 23, 2015 3:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Richard Cochran
> Subject: [Intel-wired-lan] [PATCH] net: igb: implement high frequency
> periodic output signals
> 
> From: Richard Cochran <richardcochran@gmail.com>
> 
> In addition to interrupt driven target time output events, the i210
> also has two programmable clock outputs.  These clocks support periods
> between 16 nanoseconds and 140 milliseconds.  This patch implements
> the periodic output function using the clock outputs when possible,
> falling back to the target time for longer periods.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_regs.h |  2 +
>  drivers/net/ethernet/intel/igb/igb_ptp.c    | 72 +++++++++++++++++++++---
> -----
>  2 files changed, 54 insertions(+), 20 deletions(-)

Checkpatch is throwing an over 80 character warning for this:
--------------------------------------------
WARNING: line over 80 characters
#139: FILE: drivers/net/ethernet/intel/igb/igb_ptp.c:561:
+                       tsauxc &= ~(TSAUXC_EN_TT1 | TSAUXC_EN_CLK1 | TSAUXC_ST1);

WARNING: line over 80 characters
#142: FILE: drivers/net/ethernet/intel/igb/igb_ptp.c:564:
+                       tsauxc &= ~(TSAUXC_EN_TT0 | TSAUXC_EN_CLK0 | TSAUXC_ST0);

total: 0 errors, 2 warnings, 0 checks, 134 lines checked

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
--------------------------------------------

Aside from that,

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
