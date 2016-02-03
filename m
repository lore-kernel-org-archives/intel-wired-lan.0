From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed,  3 Feb 2016 09:20:48 +0100
Subject: [Intel-wired-lan] [PATCH net-next V2 2/6] ixgbe: call ndo_stop()
	instead of dev_close() when running offline selftest
In-Reply-To: <1454487652-1545-1-git-send-email-sassmann@kpanic.de>
References: <1454487652-1545-1-git-send-email-sassmann@kpanic.de>
Message-ID: <1454487652-1545-3-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Calling dev_close() causes IFF_UP to be cleared which will remove the
interfaces routes and some addresses. That's probably not what the user
intended when running the offline selftest. Besides this does not happen
if the interface is brought down before the test, so the current
behaviour is inconsistent.
Instead call the net_device_ops ndo_stop function directly and avoid
touching IFF_UP at all.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 4b9156c..6cf1ac7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -875,6 +875,8 @@ extern const char ixgbe_driver_version[];
 extern char ixgbe_default_device_descr[];
 #endif /* IXGBE_FCOE */
 
+int ixgbe_open(struct net_device *netdev);
+int ixgbe_close(struct net_device *netdev);
 void ixgbe_up(struct ixgbe_adapter *adapter);
 void ixgbe_down(struct ixgbe_adapter *adapter);
 void ixgbe_reinit_locked(struct ixgbe_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index bea96b3..2f05937 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2053,7 +2053,7 @@ static void ixgbe_diag_test(struct net_device *netdev,
 
 		if (if_running)
 			/* indicate we're in test mode */
-			dev_close(netdev);
+			ixgbe_close(netdev);
 		else
 			ixgbe_reset(adapter);
 
@@ -2091,7 +2091,7 @@ skip_loopback:
 		/* clear testing bit and return adapter to previous state */
 		clear_bit(__IXGBE_TESTING, &adapter->state);
 		if (if_running)
-			dev_open(netdev);
+			ixgbe_open(netdev);
 		else if (hw->mac.ops.disable_tx_laser)
 			hw->mac.ops.disable_tx_laser(hw);
 	} else {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c4003a8..354be34 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5988,7 +5988,7 @@ static int ixgbe_change_mtu(struct net_device *netdev, int new_mtu)
  * handler is registered with the OS, the watchdog timer is started,
  * and the stack is notified that the interface is ready.
  **/
-static int ixgbe_open(struct net_device *netdev)
+int ixgbe_open(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -6090,7 +6090,7 @@ static void ixgbe_close_suspend(struct ixgbe_adapter *adapter)
  * needs to be disabled.  A global MAC reset is issued to stop the
  * hardware, and all transmit and receive resources are freed.
  **/
-static int ixgbe_close(struct net_device *netdev)
+int ixgbe_close(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 
-- 
2.5.0

