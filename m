From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 04 Sep 2019 08:07:11 -0700
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Prevent u8 wrapping of
 ITR value to something less than 10us
Message-ID: <20190904150703.13516.21103.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

There were a couple cases where the ITR value generated via the adaptive
ITR scheme could exceed 126. This resulted in the value becoming either 0
or something less than 10. Switching back and forth between a value less
than 10 and a value greater than 10 can cause issues as certain hardware
features such as RSC to not function well when the ITR value has dropped
that low.

Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5fa585dfddf6..097e6dfbf65a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2621,7 +2621,7 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 		/* 16K ints/sec to 9.2K ints/sec */
 		avg_wire_size *= 15;
 		avg_wire_size += 11452;
-	} else if (avg_wire_size <= 1980) {
+	} else if (avg_wire_size < 1968) {
 		/* 9.2K ints/sec to 8K ints/sec */
 		avg_wire_size *= 5;
 		avg_wire_size += 22420;
@@ -2654,6 +2654,8 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
 	case IXGBE_LINK_SPEED_2_5GB_FULL:
 	case IXGBE_LINK_SPEED_1GB_FULL:
 	case IXGBE_LINK_SPEED_10_FULL:
+		if (avg_wire_size > 8064)
+			avg_wire_size = 8064;
 		itr += DIV_ROUND_UP(avg_wire_size,
 				    IXGBE_ITR_ADAPTIVE_MIN_INC * 64) *
 		       IXGBE_ITR_ADAPTIVE_MIN_INC;

