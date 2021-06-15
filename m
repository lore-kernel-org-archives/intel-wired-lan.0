From: Colin King <colin.king@canonical.com>
Date: Tue, 15 Jun 2021 15:28:47 +0100
Subject: [Intel-wired-lan] [PATCH][next] ice: remove redundant continue
 statement in a for-loop
Message-ID: <20210615142847.60161-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The continue statement in the for-loop is redundant. Re-work the hw_lock
check to remove it.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 267312fad59a..3eca0e4eab0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -410,13 +410,11 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	for (i = 0; i < MAX_TRIES; i++) {
 		hw_lock = rd32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
 		hw_lock = hw_lock & PFTSYN_SEM_BUSY_M;
-		if (hw_lock) {
-			/* Somebody is holding the lock */
-			usleep_range(10000, 20000);
-			continue;
-		} else {
+		if (!hw_lock)
 			break;
-		}
+
+		/* Somebody is holding the lock */
+		usleep_range(10000, 20000);
 	}
 
 	return !hw_lock;
-- 
2.31.1

