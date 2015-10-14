From: Nicholas Krause <xerofoify@gmail.com>
Date: Wed, 14 Oct 2015 18:57:59 -0400
Subject: [Intel-wired-lan] [PATCH 2/2] ixgb:Make the function ixgb_sw_init
	void
In-Reply-To: <1444863479-31570-1-git-send-email-xerofoify@gmail.com>
References: <1444863479-31570-1-git-send-email-xerofoify@gmail.com>
Message-ID: <1444863479-31570-2-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This makes the function ixgb_sw_init void now due to this function
always running successfully and the unnessary error path in the
function ixgb_probe being removed that checks and always gets
the kernel value for success of zero when checking the return

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index 4a90f36..fc15a09 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -74,7 +74,7 @@ static int ixgb_init_module(void);
 static void ixgb_exit_module(void);
 static int ixgb_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void ixgb_remove(struct pci_dev *pdev);
-static int ixgb_sw_init(struct ixgb_adapter *adapter);
+static void ixgb_sw_init(struct ixgb_adapter *adapter);
 static int ixgb_open(struct net_device *netdev);
 static int ixgb_close(struct net_device *netdev);
 static void ixgb_configure_tx(struct ixgb_adapter *adapter);
@@ -577,7 +577,7 @@ ixgb_remove(struct pci_dev *pdev)
  * OS network device settings (MTU size).
  **/
 
-static int
+static void
 ixgb_sw_init(struct ixgb_adapter *adapter)
 {
 	struct ixgb_hw *hw = &adapter->hw;
@@ -608,7 +608,6 @@ ixgb_sw_init(struct ixgb_adapter *adapter)
 	hw->fc.send_xon = 1;
 
 	set_bit(__IXGB_DOWN, &adapter->flags);
-	return 0;
 }
 
 /**
-- 
2.1.4

