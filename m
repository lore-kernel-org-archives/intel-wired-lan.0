From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 25 Apr 2016 23:08:00 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e:
 e1000e_cyclecounter_read():	fix er32(SYSTIML) overflow check
In-Reply-To: <1461167156-6737-2-git-send-email-dvlasenk@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
 <1461167156-6737-2-git-send-email-dvlasenk@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EF174C@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: e1000e_cyclecounter_read():
> fix er32(SYSTIML) overflow check
> 
> If two consecutive reads of the counter are the same, it is also not an
> overflow.
> "systimel_1 < systimel_2" should be "systimel_1 <= systimel_2".
> 
> Before the patch, we could perform an *erroneous* correction:
> 
> Let's say that systimel_1 == systimel_2 == 0xffffffff.
> "systimel_1 < systimel_2" is false, we think it's an overflow,
> we read "systimeh = er32(SYSTIMH)" which meanwhile had incremented,
> and use "(systimeh << 32) + systimel_2" value which is 2^32 too large.
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: intel-wired-lan at lists.osuosl.org
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch also gives me the possible unwrapped commit description (prefer a maximum 75 chars per line) warning but otherwise seems fine.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
