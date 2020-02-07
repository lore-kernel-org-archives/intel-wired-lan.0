From: kbuild test robot <lkp@intel.com>
Date: Sat, 8 Feb 2020 01:58:27 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] gwdpa: gswip:
 mac_get_speed() can be static
In-Reply-To: <202002080142.jXgA7Lza%lkp@intel.com>
References: <202002080142.jXgA7Lza%lkp@intel.com>
Message-ID: <20200207175827.vnfqd6flcsdymvoi@f53c9c00458a>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: efd2087941d2 ("gwdpa: gswip: Introduce Gigabit Ethernet Switch (GSWIP) device driver")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 mac_cfg.c |   14 +++++++-------
 xgmac.c   |    8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c b/drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c
index 0e57404f00156..75776f402b608 100644
--- a/drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c
+++ b/drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c
@@ -35,7 +35,7 @@ static int mac_speed_to_val(u32 speed)
 	return val;
 }
 
-int mac_get_speed(struct device *dev)
+static int mac_get_speed(struct device *dev)
 {
 	struct gswip_mac *priv = dev_get_drvdata(dev);
 	u32 mac_speed;
@@ -47,7 +47,7 @@ int mac_get_speed(struct device *dev)
 	return mac_speed_to_val(mac_speed);
 }
 
-int mac_set_physpeed(struct gswip_mac *priv, u32 phy_speed)
+static int mac_set_physpeed(struct gswip_mac *priv, u32 phy_speed)
 {
 	spin_lock_bh(&priv->mac_lock);
 	xgmac_set_extcfg(priv, 1);
@@ -116,7 +116,7 @@ int mac_set_physpeed(struct gswip_mac *priv, u32 phy_speed)
 	return 0;
 }
 
-int mac_set_duplex(struct gswip_mac *priv, u32 mode)
+static int mac_set_duplex(struct gswip_mac *priv, u32 mode)
 {
 	u32 val;
 
@@ -141,7 +141,7 @@ int mac_set_duplex(struct gswip_mac *priv, u32 mode)
 	return 0;
 }
 
-int mac_get_duplex(struct device *dev)
+static int mac_get_duplex(struct device *dev)
 {
 	struct gswip_mac *priv = dev_get_drvdata(dev);
 	int val;
@@ -153,7 +153,7 @@ int mac_get_duplex(struct device *dev)
 	return val;
 }
 
-int mac_get_linksts(struct device *dev)
+static int mac_get_linksts(struct device *dev)
 {
 	struct gswip_mac *priv = dev_get_drvdata(dev);
 	int linksts;
@@ -165,7 +165,7 @@ int mac_get_linksts(struct device *dev)
 	return linksts;
 }
 
-int mac_set_linksts(struct gswip_mac *priv, u32 mode)
+static int mac_set_linksts(struct gswip_mac *priv, u32 mode)
 {
 	u8 val;
 
@@ -190,7 +190,7 @@ int mac_set_linksts(struct gswip_mac *priv, u32 mode)
 	return 0;
 }
 
-int mac_set_flowctrl(struct device *dev, u32 val)
+static int mac_set_flowctrl(struct device *dev, u32 val)
 {
 	struct gswip_mac *priv = dev_get_drvdata(dev);
 
diff --git a/drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c b/drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c
index 959b0e0e04ed8..618a63a32cb0e 100644
--- a/drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c
+++ b/drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c
@@ -475,8 +475,8 @@ int xgmac_mdio_set_clause(struct gswip_mac *priv, u32 clause, u32 phy_id)
 	return 0;
 }
 
-int xgmac_mdio_single_wr(struct gswip_mac *priv, u32 dev_adr, u32 phy_id,
-			 u32 phy_reg, u32 phy_reg_data)
+static int xgmac_mdio_single_wr(struct gswip_mac *priv, u32 dev_adr, u32 phy_id,
+				u32 phy_reg, u32 phy_reg_data)
 {
 	u32 mdio_sccdr, mdio_scar;
 	u32 retries = 100;
@@ -526,8 +526,8 @@ int xgmac_mdio_single_wr(struct gswip_mac *priv, u32 dev_adr, u32 phy_id,
 	return 0;
 }
 
-int xgmac_mdio_single_rd(struct gswip_mac *priv, u32 dev_adr, u32 phy_id,
-			 u32 phy_reg)
+static int xgmac_mdio_single_rd(struct gswip_mac *priv, u32 dev_adr, u32 phy_id,
+				u32 phy_reg)
 {
 	u32 mdio_sccdr, mdio_scar;
 	u32 retries = 100;
