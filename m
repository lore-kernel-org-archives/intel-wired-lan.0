From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun,  3 Jan 2016 07:44:56 +0100
Subject: [Intel-wired-lan] [PATCH] igb: constify e1000_phy_operations
	structure
Message-ID: <1451803496-16693-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This e1000_phy_operations structure is never modified, so declare it as
const.  Other structures of this type are already const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/intel/igb/e1000_82575.c |    2 +-
 drivers/net/ethernet/intel/igb/e1000_hw.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index adb33e2..1ea27bf 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2889,7 +2889,7 @@ static struct e1000_mac_operations e1000_mac_ops_82575 = {
 #endif
 };
 
-static struct e1000_phy_operations e1000_phy_ops_82575 = {
+static const struct e1000_phy_operations e1000_phy_ops_82575 = {
 	.acquire              = igb_acquire_phy_82575,
 	.get_cfg_done         = igb_get_cfg_done_82575,
 	.release              = igb_release_phy_82575,
diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
index 4034207..a34d640 100644
--- a/drivers/net/ethernet/intel/igb/e1000_hw.h
+++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
@@ -372,7 +372,7 @@ struct e1000_thermal_sensor_data {
 struct e1000_info {
 	s32 (*get_invariants)(struct e1000_hw *);
 	struct e1000_mac_operations *mac_ops;
-	struct e1000_phy_operations *phy_ops;
+	const struct e1000_phy_operations *phy_ops;
 	struct e1000_nvm_operations *nvm_ops;
 };
 

