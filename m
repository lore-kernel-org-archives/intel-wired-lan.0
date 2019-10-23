From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 23 Oct 2019 18:09:17 +0300
Subject: [Intel-wired-lan] [PATCH v1] e1000e: Fix compiler warning when
 CONFIG_PM_SLEEP is not set
Message-ID: <20191023150917.26271-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When CONFIG_PM_SLEEP is not defined compiler complain as follow:
CC [M]  drivers/net/ethernet/intel/e1000e/netdev.o
drivers/net/ethernet/intel/e1000e/netdev.c:6302:12: warning: ?e1000e_s0ix_entry_flow? defined but not used [-Wunused-function]
static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
drivers/net/ethernet/intel/e1000e/netdev.c:6411:12: warning: ?e1000e_s0ix_exit_flow? defined but not used [-Wunused-function]
static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
LD [M]  drivers/net/ethernet/intel/e1000e/e1000e.o

Add wrap to fix these warnings.

Reported-by: kbuild test robot <lpk@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 20965b5d9780..032b88619054 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6297,6 +6297,7 @@ static void e1000e_flush_lpic(struct pci_dev *pdev)
 	pm_runtime_put_sync(netdev->dev.parent);
 }
 
+#ifdef CONFIG_PM_SLEEP
 /* S0ix implementation */
 static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 {
@@ -6464,6 +6465,7 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	mac_data &= ~E1000_CTRL_EXT_FORCE_SMBUS;
 	ew32(CTRL_EXT, mac_data);
 }
+#endif /* CONFIG_PM_SLEEP */
 
 static int e1000e_pm_freeze(struct device *dev)
 {
-- 
2.11.0

