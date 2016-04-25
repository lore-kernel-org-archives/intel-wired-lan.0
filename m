From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 25 Apr 2016 23:12:20 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e:
 e1000e_cyclecounter_read():	do overflow check only if needed
In-Reply-To: <1461167156-6737-3-git-send-email-dvlasenk@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
 <1461167156-6737-3-git-send-email-dvlasenk@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EF178F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Denys Vlasenko
> Sent: Wednesday, April 20, 2016 8:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: e1000e_cyclecounter_read():
> do overflow check only if needed
> 
> SYSTIMH:SYSTIML registers are incremented by 24-bit value TIMINCA[23..0]
> 
> er32(SYSTIML) are probably moderately expensive (they are pci bus reads).
> Can we avoid one of them? Yes, we can.
> 
> If the SYSTIML value we see is smaller than 0xff000000, the overflow
> into SYSTIMH would require at least two increments.
> 
> We do two reads, er32(SYSTIML) and er32(SYSTIMH), in this order.
> 
> Even if one increment happens between them, the overflow into SYSTIMH
> is impossible, and we can avoid doing another er32(SYSTIML) read
> and overflow check.
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: intel-wired-lan at lists.osuosl.org
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

This one throws a different checkpatch warning:
WARNING: Missing a blank line after declarations
#61: FILE: drivers/net/ethernet/intel/e1000e/netdev.c:4327:
+               u32 systimel_2 = er32(SYSTIML);
+               if (systimel > systimel_2) {

Still just a warning and I'm not seeing functional problems with it.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
