From: Feng Tang <feng.tang@intel.com>
Date: Thu, 23 May 2019 11:22:33 +0800
Subject: [Intel-wired-lan] [RESEND PATCH] intel-ethernet: warn when fatal
 read failure happens
Message-ID: <20190523032233.29277-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Failed in reading the HW register is very serious for igb/igc driver,
as its hw_addr will be set to NULL and cause the adapter be seen as
"REMOVED".

We saw the error only a few times in the MTBF test for suspend/resume,
but can hardly get any useful info to debug.

Adding WARN() so that we can get the necessary information about
where and how it happens, and use it for root causing and fixing
this "PCIe link lost issue"

This affects igb, igc.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 39f33afc479c..e5b7e638df28 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -753,6 +753,7 @@ u32 igb_rd32(struct e1000_hw *hw, u32 reg)
 		struct net_device *netdev = igb->netdev;
 		hw->hw_addr = NULL;
 		netdev_err(netdev, "PCIe link lost\n");
+		WARN(1, "igb: Failed to read reg 0x%x!\n", reg);
 	}
 
 	return value;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 34fa0e60a780..28072b9aa932 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3934,6 +3934,7 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
 		hw->hw_addr = NULL;
 		netif_device_detach(netdev);
 		netdev_err(netdev, "PCIe link lost, device now detached\n");
+		WARN(1, "igc: Failed to read reg 0x%x!\n", reg);
 	}
 
 	return value;
-- 
2.14.1

