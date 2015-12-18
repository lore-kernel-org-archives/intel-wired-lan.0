From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 18 Dec 2015 01:49:47 +0000
Subject: [Intel-wired-lan] [next PATCH] igb/igbvf: don't give up
In-Reply-To: <1449881138-19985-1-git-send-email-mitch.a.williams@intel.com>
References: <1449881138-19985-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E30D1D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Mitch Williams [mitch.a.williams at intel.com]
> Sent: Friday, December 11, 2015 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH] igb/igbvf: don't give up
> 
> The driver shouldn't just give up if it fails to get the hardware
> mailbox lock. This can happen in a situation where the PF-VF
> communication channel is heavily loaded and causes complete
> communications failure between the PF and VF drivers.
> 
> Add a counter and a delay. The driver will now retry ten times, waiting
> one millsecond between retries.

> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_mbx.c | 18 ++++++++++++------
>  drivers/net/ethernet/intel/igbvf/mbx.c     | 20 +++++++++++++-------
>  2 files changed, 25 insertions(+), 13 deletions(-)

This is getting flagged by checkpatch for using udelay rather than usleep_range.  But it does not seem to be considering it an error or even a warning, rather it just seems to come up as a "CHECK:".

Is there any reason not to use usleep_range here?
--------------------------------------------------------------------------------------------
u1458:[1]/usr/src/kernels/next-queue> git format-patch $item -1 --stdout|./scripts/checkpatch.pl -
CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt
#46: FILE: drivers/net/ethernet/intel/igb/e1000_mbx.c:337:
+		udelay(1000);

CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt
#77: FILE: drivers/net/ethernet/intel/igbvf/mbx.c:248:
+		udelay(1000);

total: 0 errors, 0 warnings, 2 checks, 52 lines checked

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
u1458:[1]/usr/src/kernels/next-queue> 
