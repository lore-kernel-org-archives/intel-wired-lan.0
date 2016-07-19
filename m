From: Jarod Wilson <jarod@redhat.com>
Date: Tue, 19 Jul 2016 16:25:02 -0400
Subject: [Intel-wired-lan] [PATCH net] e1000e: fix PTP on e1000_pch_lpt
	variants
Message-ID: <1468959902-25071-1-git-send-email-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I've got reports that the Intel I-218V NIC in Intel NUC5i5RYH systems used
as a PTP slave experiences random ~10 hour clock jumps, which are resolved
if the same workaround for the 82574 and 82583 is employed. Switching from
an if to a select, because the list of NIC types could well grow further
and we'd already have to wrap the conditionals.

CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: intel-wired-lan at lists.osuosl.org
CC: netdev at vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 2b2e2f8..866fea0 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4335,7 +4335,10 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 	systim = (cycle_t)systimel;
 	systim |= (cycle_t)systimeh << 32;
 
-	if ((hw->mac.type == e1000_82574) || (hw->mac.type == e1000_82583)) {
+	switch (hw->mac.type) {
+	case e1000_82574:
+	case e1000_82583:
+	case e1000_pch_lpt:
 		u64 time_delta, rem, temp;
 		u32 incvalue;
 		int i;
@@ -4360,6 +4363,9 @@ static cycle_t e1000e_cyclecounter_read(const struct cyclecounter *cc)
 			    (rem == 0))
 				break;
 		}
+		break;
+	default:
+		break;
 	}
 	return systim;
 }
-- 
1.8.3.1

