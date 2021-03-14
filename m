From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 14 Mar 2021 15:59:20 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Fix prototype warning
Message-ID: <20210314135920.56649-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Correct report warnings in ich8lan.c, netdev.c phy.c and ptp.c files

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c  | 6 +++---
 drivers/net/ethernet/intel/e1000e/phy.c     | 2 +-
 drivers/net/ethernet/intel/e1000e/ptp.c     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 8c5aaa523b01..5dd82414c6a6 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -2750,7 +2750,7 @@ static s32 e1000_lv_phy_workarounds_ich8lan(struct e1000_hw *hw)
 }
 
 /**
- *  e1000_k1_gig_workaround_lv - K1 Si workaround
+ *  e1000_k1_workaround_lv - K1 Si workaround
  *  @hw:   pointer to the HW structure
  *
  *  Workaround to set the K1 beacon duration for 82579 parts in 10Mbps
@@ -5227,7 +5227,7 @@ void e1000e_set_kmrn_lock_loss_workaround_ich8lan(struct e1000_hw *hw,
 }
 
 /**
- *  e1000_ipg3_phy_powerdown_workaround_ich8lan - Power down workaround on D3
+ *  e1000e_igp3_phy_powerdown_workaround_ich8lan - Power down workaround on D3
  *  @hw: pointer to the HW structure
  *
  *  Workaround for 82566 power-down on D3 entry:
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ecbe91cb95ed..efa42a6a2f3c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5993,7 +5993,7 @@ static void e1000_reset_task(struct work_struct *work)
 }
 
 /**
- * e1000_get_stats64 - Get System Network Statistics
+ * e1000e_get_stats64 - Get System Network Statistics
  * @netdev: network interface device structure
  * @stats: rtnl_link_stats64 pointer
  *
@@ -6166,7 +6166,7 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
 }
 
 /**
- * e1000e_hwtstamp_ioctl - control hardware time stamping
+ * e1000e_hwtstamp_set - control hardware time stamping
  * @netdev: network interface device structure
  * @ifr: interface request
  *
@@ -6824,7 +6824,7 @@ static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
 }
 
 /**
- * e1000e_disable_aspm_locked   Disable ASPM states.
+ * e1000e_disable_aspm_locked - Disable ASPM states.
  * @pdev: pointer to PCI device struct
  * @state: bit-mask of ASPM states to disable
  *
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index bdd9dc163f15..1db35b2c7750 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -371,7 +371,7 @@ s32 e1000e_read_phy_reg_igp_locked(struct e1000_hw *hw, u32 offset, u16 *data)
 }
 
 /**
- *  e1000e_write_phy_reg_igp - Write igp PHY register
+ *  __e1000e_write_phy_reg_igp - Write igp PHY register
  *  @hw: pointer to the HW structure
  *  @offset: register offset to write to
  *  @data: data to write at register offset
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 41213baee050..eb5c014c02fb 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -142,7 +142,7 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *device,
 }
 
 /**
- * e1000e_phc_getsynctime - Reads the current system/device cross timestamp
+ * e1000e_phc_getcrosststamp - Reads the current system/device cross timestamp
  * @ptp: ptp clock structure
  * @xtstamp: structure containing timestamp
  *
-- 
2.25.1

