From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 09 Nov 2015 15:07:12 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: add support for QSFP phy types in
 ixgbe_get_settings()
Message-ID: <20151109230712.26966.5947.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add missing QSFP PHY types to allow for more accurate reporting of
port settings.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 1ed4c9a..e10d197 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -225,6 +225,10 @@ static int ixgbe_get_settings(struct net_device *netdev,
 	case ixgbe_phy_sfp_avago:
 	case ixgbe_phy_sfp_intel:
 	case ixgbe_phy_sfp_unknown:
+	case ixgbe_phy_qsfp_passive_unknown:
+	case ixgbe_phy_qsfp_active_unknown:
+	case ixgbe_phy_qsfp_intel:
+	case ixgbe_phy_qsfp_unknown:
 		/* SFP+ devices, further checking needed */
 		switch (adapter->hw.phy.sfp_type) {
 		case ixgbe_sfp_type_da_cu:

