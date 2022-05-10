From: Michal Michalik <michal.michalik@intel.com>
Date: Tue, 10 May 2022 13:03:43 +0200
Subject: [Intel-wired-lan] [PATCH net v1] ice: Fix PTP TX timestamp offset
 calculation
Message-ID: <20220510110343.5665-1-michal.michalik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The offset was being incorrectly calculated for E822 - that led to
collisions in choosing TX timestamp register location when more than
one port was trying to use timestamping mechanism.

In E822 one quad is being logically split between ports, so quad 0 is
having trackers for ports 0-3, quad 1 ports 4-7 etc. Each port should
have separate memory location for tracking timestamps. Due to error for
example ports 1 and 2 had been assigned to quad 0 with same offset (0),
while port 1 should have offset 0 and 1 offset 16.

Fix it by correctly calculating quad offset.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 662947c..ef9344e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2271,7 +2271,7 @@ static int
 ice_ptp_init_tx_e822(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 {
 	tx->quad = port / ICE_PORTS_PER_QUAD;
-	tx->quad_offset = tx->quad * INDEX_PER_PORT;
+	tx->quad_offset = (port % ICE_PORTS_PER_QUAD) * INDEX_PER_PORT;
 	tx->len = INDEX_PER_PORT;
 
 	return ice_ptp_alloc_tx_tracker(tx);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index afd048d..9c34cdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -49,6 +49,36 @@ struct ice_perout_channel {
  * To allow multiple ports to access the shared register block independently,
  * the blocks are split up so that indexes are assigned to each port based on
  * hardware logical port number.
+ *
+ * The timestamp blocks are handled differently for E810- and E822-based
+ * devices. In E810 devices, each port has its own block of timestamps, while in
+ * E822 there is a need to logically break the block of registers into smaller
+ * chunks based on the port number to avoid collisions.
+ *
+ * Example for port 5 in E810:
+ *  +--------+--------+--------+--------+--------+--------+--------+--------+
+ *  |register|register|register|register|register|register|register|register|
+ *  | block  | block  | block  | block  | block  | block  | block  | block  |
+ *  |  for   |  for   |  for   |  for   |  for   |  for   |  for   |  for   |
+ *  | port 0 | port 1 | port 2 | port 3 | port 4 | port 5 | port 6 | port 7 |
+ *  +--------+--------+--------+--------+--------+--------+--------+--------+
+ *                                               ??????
+ *                                               |???--  quad offset is always 0
+ *                                               ???--- quad number
+ *
+ * Example for port 5 in E822:
+ * +-----------------------------+-----------------------------+
+ * |  register block for quad 0  |  register block for quad 1  |
+ * |+------+------+------+------+|+------+------+------+------+|
+ * ||port 0|port 1|port 2|port 3|||port 0|port 1|port 2|port 3||
+ * |+------+------+------+------+|+------+------+------+------+|
+ * +-----------------------------+-------???---------------------+
+ *                                ???      |
+ *                                |      ???-- quad offset*
+ *                                ???--- quad number
+ *
+ *   * PHY port 5 is port 1 in quad 1
+ *
  */
 
 /**
-- 
2.9.5

base-commit: 5d171c65e5c52a1bfdcb347c921dd0f24ca0b91d
