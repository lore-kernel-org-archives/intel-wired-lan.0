From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 27 Oct 2015 16:59:31 -0700
Subject: [Intel-wired-lan] [next PATCH 4/5] e1000e: Switch e1000e_up to void,
 drop code checking for error result
In-Reply-To: <20151027235341.30048.46286.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
Message-ID: <20151027235931.30048.548.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function e1000e_up always returns 0.  As such we can convert it to a
void and just ignore the results.  This allows us to drop some code in a
couple spots as we no longer need to worry about non-zero return values.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |    2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c |   15 ++++-----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 0b748d1959d9..1dc293bad87b 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -480,7 +480,7 @@ extern const char e1000e_driver_version[];
 void e1000e_check_options(struct e1000_adapter *adapter);
 void e1000e_set_ethtool_ops(struct net_device *netdev);
 
-int e1000e_up(struct e1000_adapter *adapter);
+void e1000e_up(struct e1000_adapter *adapter);
 void e1000e_down(struct e1000_adapter *adapter, bool reset);
 void e1000e_reinit_locked(struct e1000_adapter *adapter);
 void e1000e_reset(struct e1000_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7a10bb0a83f4..4ed69fee8549 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4143,7 +4143,7 @@ void e1000e_reset(struct e1000_adapter *adapter)
 
 }
 
-int e1000e_up(struct e1000_adapter *adapter)
+void e1000e_up(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 
@@ -4163,8 +4163,6 @@ int e1000e_up(struct e1000_adapter *adapter)
 		ew32(ICS, E1000_ICS_LSC | E1000_ICR_OTHER);
 	else
 		ew32(ICS, E1000_ICS_LSC);
-
-	return 0;
 }
 
 static void e1000e_flush_descriptors(struct e1000_adapter *adapter)
@@ -6643,7 +6641,7 @@ static int e1000e_pm_runtime_resume(struct device *dev)
 		return rc;
 
 	if (netdev->flags & IFF_UP)
-		rc = e1000e_up(adapter);
+		e1000e_up(adapter);
 
 	return rc;
 }
@@ -6834,13 +6832,8 @@ static void e1000_io_resume(struct pci_dev *pdev)
 
 	e1000_init_manageability_pt(adapter);
 
-	if (netif_running(netdev)) {
-		if (e1000e_up(adapter)) {
-			dev_err(&pdev->dev,
-				"can't bring device back up after reset\n");
-			return;
-		}
-	}
+	if (netif_running(netdev))
+		e1000e_up(adapter);
 
 	netif_device_attach(netdev);
 

