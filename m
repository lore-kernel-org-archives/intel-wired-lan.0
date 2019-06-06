From: Colin King <colin.king@canonical.com>
Date: Thu,  6 Jun 2019 14:10:53 +0100
Subject: [Intel-wired-lan] [PATCH][next] ixgbe: fix potential u32 overflow
 on shift
Message-ID: <20190606131053.25103-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The u32 variable rem is being shifted using u32 arithmetic however
it is being passed to div_u64 that expects the expression to be a u64.
The 32 bit shift may potentially overflow, so cast rem to a u64 before
shifting to avoid this.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: cd4583206990 ("ixgbe: implement support for SDP/PPS output on X550 hardware")
Fixes: 68d9676fc04e ("ixgbe: fix PTP SDP pin setup on X540 hardware")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 2c4d327fcc2e..ff229d0e9146 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -209,7 +209,7 @@ static void ixgbe_ptp_setup_sdp_X540(struct ixgbe_adapter *adapter)
 	 * assumes that the cycle counter shift is small enough to avoid
 	 * overflowing when shifting the remainder.
 	 */
-	clock_edge += div_u64((rem << cc->shift), cc->mult);
+	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
 	trgttiml = (u32)clock_edge;
 	trgttimh = (u32)(clock_edge >> 32);
 
@@ -295,7 +295,7 @@ static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter *adapter)
 	 * assumes that the cycle counter shift is small enough to avoid
 	 * overflowing when shifting the remainder.
 	 */
-	clock_edge += div_u64((rem << cc->shift), cc->mult);
+	clock_edge += div_u64(((u64)rem << cc->shift), cc->mult);
 
 	/* X550 hardware stores the time in 32bits of 'billions of cycles' and
 	 * 32bits of 'cycles'. There's no guarantee that cycles represents
-- 
2.20.1

