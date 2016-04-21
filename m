From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Thu, 21 Apr 2016 14:41:46 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e:
 e1000e_cyclecounter_read():	incvalue is 32 bits, not 64
In-Reply-To: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
Message-ID: <36CDDD56DDB4D44E911123902EFC26B05B47C73B@HASMSX110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Probably a good idea. do_div() truncates the divisor to 32 bits anyways.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Denys Vlasenko
Sent: Wednesday, 20 April, 2016 18:46
To: intel-wired-lan@lists.osuosl.org
Cc: Denys Vlasenko
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: e1000e_cyclecounter_read(): incvalue is 32 bits, not 64

"incvalue" variable holds a result of "er32(TIMINCA) & E1000_TIMINCA_INCVALUE_MASK"
and used in "do_div(temp, incvalue)" as a divisor.

Thus, "u64 incvalue" declaration is probably a mistake.
Even though it seems to be a harmless one, let's fix it.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: intel-wired-lan at lists.osuosl.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9b4ec13..967311b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4300,7 +4300,8 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	}
 
 	if ((hw->mac.type == e1000_82574) || (hw->mac.type == e1000_82583)) {
-		u64 incvalue, time_delta, rem, temp;
+		u64 time_delta, rem, temp;
+		u32 incvalue;
 		int i;
 
 		/* errata for 82574/82583 possible bad bits read from SYSTIMH/L
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

