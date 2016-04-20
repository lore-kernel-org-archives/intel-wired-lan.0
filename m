From: Denys Vlasenko <dvlasenk@redhat.com>
Date: Wed, 20 Apr 2016 17:45:55 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: e1000e_cyclecounter_read():
	fix er32(SYSTIML) overflow check
In-Reply-To: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
Message-ID: <1461167156-6737-2-git-send-email-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

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

