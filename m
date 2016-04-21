From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Thu, 21 Apr 2016 14:49:56 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e:
 e1000e_cyclecounter_read():	do overflow check only if needed
In-Reply-To: <1461167156-6737-3-git-send-email-dvlasenk@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
 <1461167156-6737-3-git-send-email-dvlasenk@redhat.com>
Message-ID: <36CDDD56DDB4D44E911123902EFC26B05B47C768@HASMSX110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Not sure I follow (perhaps I am missing some background). Why do you assume there can be only 1 or 2 increments?

In general, unless you are combating an active performance issue, I am not a fan of making the code more complex, in order to save one PCI read (how expensive are they anyway?)

--Dima

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Denys Vlasenko
Sent: Wednesday, 20 April, 2016 18:46
To: intel-wired-lan@lists.osuosl.org
Cc: Denys Vlasenko
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: e1000e_cyclecounter_read(): do overflow check only if needed

SYSTIMH:SYSTIML registers are incremented by 24-bit value TIMINCA[23..0]

er32(SYSTIML) are probably moderately expensive (they are pci bus reads).
Can we avoid one of them? Yes, we can.

If the SYSTIML value we see is smaller than 0xff000000, the overflow into SYSTIMH would require at least two increments.

We do two reads, er32(SYSTIML) and er32(SYSTIMH), in this order.

Even if one increment happens between them, the overflow into SYSTIMH is impossible, and we can avoid doing another er32(SYSTIML) read and overflow check.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: intel-wired-lan at lists.osuosl.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 99d0e6e..6f17f89 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4275,7 +4275,7 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	struct e1000_adapter *adapter = container_of(cc, struct e1000_adapter,
 						     cc);
 	struct e1000_hw *hw = &adapter->hw;
-	u32 systimel_1, systimel_2, systimeh;
+	u32 systimel, systimeh;
 	cycle_t systim, systim_next;
 	/* SYSTIMH latching upon SYSTIML read does not work well.
 	 * This means that if SYSTIML overflows after we read it but before @@ -4283,21 +4283,21 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	 * will experience a huge non linear increment in the systime value
 	 * to fix that we test for overflow and if true, we re-read systime.
 	 */
-	systimel_1 = er32(SYSTIML);
+	systimel = er32(SYSTIML);
 	systimeh = er32(SYSTIMH);
-	systimel_2 = er32(SYSTIML);
-	/* Check for overflow. If there was no overflow, use the values */
-	if (systimel_1 <= systimel_2) {
-		systim = (cycle_t)systimel_1;
-		systim |= (cycle_t)systimeh << 32;
-	} else {
-		/* There was an overflow, read again SYSTIMH, and use
-		 * systimel_2
-		 */
-		systimeh = er32(SYSTIMH);
-		systim = (cycle_t)systimel_2;
-		systim |= (cycle_t)systimeh << 32;
+	/* Is systimel is so large that overflow is possible? */
+	if (systimel >= (u32)0xffffffff - E1000_TIMINCA_INCVALUE_MASK) {
+		u32 systimel_2 = er32(SYSTIML);
+		if (systimel > systimel_2) {
+			/* There was an overflow, read again SYSTIMH, and use
+			 * systimel_2
+			 */
+			systimeh = er32(SYSTIMH);
+			systimel = systimel_2;
+		}
 	}
+	systim = (cycle_t)systimel;
+	systim |= (cycle_t)systimeh << 32;
 
 	if ((hw->mac.type == e1000_82574) || (hw->mac.type == e1000_82583)) {
 		u64 time_delta, rem, temp;
--
1.8.1.4

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

