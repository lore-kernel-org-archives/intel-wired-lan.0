From: Jiri Kosina <jikos@kernel.org>
Date: Wed, 2 Jan 2019 20:20:33 +0100 (CET)
Subject: [Intel-wired-lan] [PATCH] ixgbe: remove magic constant in
 ixgbe_reset_hw_82599()
Message-ID: <nycvar.YFH.7.76.1901022016380.14047@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Kosina <jkosina@suse.cz>

ixgbe_reset_hw_82599() resets the value of hw->mac.num_rar_entries to 
pre-defined value of 128. Let's get rid of that hardcoded literal, and use 
IXGBE_82599_RAR_ENTRIES instead, the same way the normal initialization 
path does.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 1e49716f52bc..109f8de5a1c2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -1048,7 +1048,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	 * clear the multicast table.  Also reset num_rar_entries to 128,
 	 * since we modify this value when programming the SAN MAC address.
 	 */
-	hw->mac.num_rar_entries = 128;
+	hw->mac.num_rar_entries = IXGBE_82599_RAR_ENTRIES;
 	hw->mac.ops.init_rx_addrs(hw);
 
 	/* Store the permanent SAN mac address */
-- 
Jiri Kosina
SUSE Labs

