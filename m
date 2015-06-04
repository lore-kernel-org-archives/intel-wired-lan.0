From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 03 Jun 2015 20:13:27 -0400
Subject: [Intel-wired-lan] [net-next PATCH 02/11] ixgbe: add define for X557
	Phy ID
In-Reply-To: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
References: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150604001327.18893.83142.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a define for the new PHY identification as well as it's mapping
to the correct PHY type.  Also allow ethtool to identify this type
as well.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     |    3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |    1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 401e1a9..f7aeb56 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -207,6 +207,7 @@ static int ixgbe_get_settings(struct net_device *netdev,
 	switch (adapter->hw.phy.type) {
 	case ixgbe_phy_tn:
 	case ixgbe_phy_aq:
+	case ixgbe_phy_x550em_ext_t:
 	case ixgbe_phy_cu_unknown:
 		ecmd->supported |= SUPPORTED_TP;
 		ecmd->advertising |= ADVERTISED_TP;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 8f9334d..47ac0bc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -356,6 +356,9 @@ static enum ixgbe_phy_type ixgbe_get_phy_type_from_id(u32 phy_id)
 	case ATH_PHY_ID:
 		phy_type = ixgbe_phy_nl;
 		break;
+	case X557_PHY_ID:
+		phy_type = ixgbe_phy_x550em_ext_t;
+		break;
 	default:
 		phy_type = ixgbe_phy_unknown;
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 67039ce..560a2b4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1334,6 +1334,7 @@ struct ixgbe_thermal_sensor_data {
 #define TN1010_PHY_ID    0x00A19410
 #define TNX_FW_REV       0xB
 #define X540_PHY_ID      0x01540200
+#define X557_PHY_ID      0x01540240
 #define QT2022_PHY_ID    0x0043A400
 #define ATH_PHY_ID       0x03429050
 #define AQ_FW_REV        0x20

