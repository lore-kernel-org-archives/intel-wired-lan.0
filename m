From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Thu, 21 Apr 2016 14:43:56 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e:
 e1000e_cyclecounter_read():	fix er32(SYSTIML) overflow check
In-Reply-To: <1461167156-6737-2-git-send-email-dvlasenk@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
 <1461167156-6737-2-git-send-email-dvlasenk@redhat.com>
Message-ID: <36CDDD56DDB4D44E911123902EFC26B05B47C74C@HASMSX110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Agree.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Denys Vlasenko
Sent: Wednesday, 20 April, 2016 18:46
To: intel-wired-lan@lists.osuosl.org
Cc: Denys Vlasenko
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: e1000e_cyclecounter_read(): fix er32(SYSTIML) overflow check

If two consecutive reads of the counter are the same, it is also not an overflow.
"systimel_1 < systimel_2" should be "systimel_1 <= systimel_2".

Before the patch, we could perform an *erroneous* correction:

Let's say that systimel_1 == systimel_2 == 0xffffffff.
"systimel_1 < systimel_2" is false, we think it's an overflow,
we read "systimeh = er32(SYSTIMH)" which meanwhile had incremented,
and use "(systimeh << 32) + systimel_2" value which is 2^32 too large.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: intel-wired-lan at lists.osuosl.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 967311b..99d0e6e 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4287,7 +4287,7 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	systimeh = er32(SYSTIMH);
 	systimel_2 = er32(SYSTIML);
 	/* Check for overflow. If there was no overflow, use the values */
-	if (systimel_1 < systimel_2) {
+	if (systimel_1 <= systimel_2) {
 		systim = (cycle_t)systimel_1;
 		systim |= (cycle_t)systimeh << 32;
 	} else {
-- 
1.8.1.4

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

