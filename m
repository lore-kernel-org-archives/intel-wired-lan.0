From: Colin King <colin.king@canonical.com>
Date: Fri,  7 Jun 2019 19:19:20 +0100
Subject: [Intel-wired-lan] [PATCH][next][V2] ixgbe: fix potential u32
 overflow on shift
Message-ID: <20190607181920.23339-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The u32 variable rem is being shifted using u32 arithmetic however
it is being passed to div_u64 that expects the expression to be a u64.
The 32 bit shift may potentially overflow, so cast rem to a u64 before
shifting to avoid this.  Also remove comment about overflow.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: cd4583206990 ("ixgbe: implement support for SDP/PPS output on X550 hardware")
Fixes: 68d9676fc04e ("ixgbe: fix PTP SDP pin setup on X540 hardware")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: update comment

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 2c4d327fcc2e..0be13a90ff79 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -205,11 +205,8 @@ static void ixgbe_ptp_setup_sdp_X540(struct ixgbe_adapter *adapter)
 	 */
 	rem = (NS_PER_SEC - rem);
 
-	/* Adjust the clock edge to align with the next full second. This
-	 * assumes that the cycle counter shift is small enough to avoid
-	 * overflowing when shifting the remainder.
-	 */
-	clock_edge += div_u64((rem << cc->shift), cc->mult);
+	/* Adjust the clock edge to align with the next full second. */
+	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
 	trgttiml = (u32)clock_edge;
 	trgttimh = (u32)(clock_edge >> 32);
 
@@ -291,11 +288,8 @@ static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter *adapter)
 	 */
 	rem = (NS_PER_SEC - rem);
 
-	/* Adjust the clock edge to align with the next full second. This
-	 * assumes that the cycle counter shift is small enough to avoid
-	 * overflowing when shifting the remainder.
-	 */
-	clock_edge += div_u64((rem << cc->shift), cc->mult);
+	/* Adjust the clock edge to align with the next full second. */
+	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
 
 	/* X550 hardware stores the time in 32bits of 'billions of cycles' and
 	 * 32bits of 'cycles'. There's no guarantee that cycles represents
-- 
2.20.1

