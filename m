From: Feng Tang <feng.tang@intel.com>
Date: Wed,  9 Jan 2019 14:30:54 +0800
Subject: [Intel-wired-lan] [PATCH] intel-ethernet: warn when fatal read
 failure happens
Message-ID: <1547015454-77750-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Failed in read the HW register is very serious for igb/igc driver,
as its hw_addr will be set to NULL and cause the adapter be seen as
"REMOVED".

We saw the error only a few times in the MTBF test for suspend/resume,
but can hardly get any useful info to debug.

Adding WARN() so that we can get the necessary information about
where and how it happens, and use it for root causing and fixing
this "PCIe link lost issue"

This affects igb, igc.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 87bdf16..eaa3d6d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -753,6 +753,7 @@ u32 igb_rd32(struct e1000_hw *hw, u32 reg)
 		struct net_device *netdev = igb->netdev;
 		hw->hw_addr = NULL;
 		netdev_err(netdev, "PCIe link lost\n");
+		WARN(1, "igb: Failed to read reg 0x%x!", reg);
 	}
 
 	return value;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f201830..72e4263 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3496,6 +3496,7 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
 		hw->hw_addr = NULL;
 		netif_device_detach(netdev);
 		netdev_err(netdev, "PCIe link lost, device now detached\n");
+		WARN(1, "igc: Failed to read reg 0x%x!", reg);
 	}
 
 	return value;
-- 
2.7.4

