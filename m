From: Saber Rezvani <irsaber@gmail.com>
Date: Fri, 10 Feb 2017 02:07:11 +0330
Subject: [Intel-wired-lan] [PATCH 1/1] net: ethernet: intel: e1000: msleep()
	is unreliable for anything <20ms
Message-ID: <1486679831-5745-1-git-send-email-irsaber@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the checkpatch.pl issue:
WARNING: msleep < 20ms can sleep for up to 20ms; see
Documentation/timers/timers-howto.txt

Signed-off-by: Saber Rezvani <irsaber@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 93fc6c6..5403fa2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -489,7 +489,7 @@ static void e1000_power_down_phy(struct e1000_adapter *adapter)
 		e1000_read_phy_reg(hw, PHY_CTRL, &mii_reg);
 		mii_reg |= MII_CR_POWER_DOWN;
 		e1000_write_phy_reg(hw, PHY_CTRL, mii_reg);
-		msleep(1);
+		usleep_range(1000, 5000);
 	}
 out:
 	return;
@@ -536,7 +536,7 @@ void e1000_down(struct e1000_adapter *adapter)
 	ew32(TCTL, tctl);
 	/* flush both disables and wait for them to finish */
 	E1000_WRITE_FLUSH();
-	msleep(10);
+	usleep_range(1000, 5000);
 
 	napi_disable(&adapter->napi);
 
@@ -560,7 +560,7 @@ void e1000_reinit_locked(struct e1000_adapter *adapter)
 {
 	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__E1000_RESETTING, &adapter->flags))
-		msleep(1);
+		usleep_range(1000, 5000);
 	e1000_down(adapter);
 	e1000_up(adapter);
 	clear_bit(__E1000_RESETTING, &adapter->flags);
@@ -3569,7 +3569,7 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 	}
 
 	while (test_and_set_bit(__E1000_RESETTING, &adapter->flags))
-		msleep(1);
+		usleep_range(1000, 5000);
 	/* e1000_down has a dependency on max_frame_size */
 	hw->max_frame_size = max_frame;
 	if (netif_running(netdev)) {
-- 
2.7.4


