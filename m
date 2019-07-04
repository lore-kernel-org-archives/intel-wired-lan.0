From: Radoslaw Tyl <radoslawx.tyl@intel.com>
Date: Thu,  4 Jul 2019 15:48:42 +0200
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Link lost in VM on ixgbevf when
 restoring from freeze or suspend
Message-ID: <20190704134842.7900-1-radoslawx.tyl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixed issue in VM which shows no link when hypervisor is
restored from low-power state. The driver is responsible for reenabling
any features of the device that had been disabled during suspend calls,
such as IRQs and bus mastering.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d189ed247665..e1b7fa9c39d6 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2514,6 +2514,7 @@ void ixgbevf_reinit_locked(struct ixgbevf_adapter *adapter)
 		msleep(1);
 
 	ixgbevf_down(adapter);
+	pci_set_master(adapter->pdev);
 	ixgbevf_up(adapter);
 
 	clear_bit(__IXGBEVF_RESETTING, &adapter->state);
-- 
2.21.0

