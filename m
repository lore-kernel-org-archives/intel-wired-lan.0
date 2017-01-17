From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 17 Jan 2017 08:37:03 -0800
Subject: [Intel-wired-lan] [next PATCH v2 09/11] ixgbe: Add private flag to
	control buffer mode
In-Reply-To: <20170117163401.5423.37993.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
Message-ID: <20170117163700.5423.65006.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Since there are potential drawbacks to the new Rx allocation approach I
thought it best to add a "chicken bit" so that we can turn the feature off
if in the event that a problem is found.

It also provides a means of validating the legacy Rx path in the event that
we are forced to fall back.  At some point in the future when we are
convinced we don't need it anymore we might be able to drop the legacy-rx
flag.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index ab189fc09298..616e47982755 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -151,6 +151,13 @@ struct ixgbe_stats {
 };
 #define IXGBE_TEST_LEN sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN
 
+static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
+#define IXGBE_PRIV_FLAGS_LEGACY_RX	BIT(0)
+	"legacy-rx",
+};
+
+#define IXGBE_PRIV_FLAGS_STR_LEN ARRAY_SIZE(ixgbe_priv_flags_strings)
+
 /* currently supported speeds for 10G */
 #define ADVRTSD_MSK_10G (SUPPORTED_10000baseT_Full | \
 			 SUPPORTED_10000baseKX4_Full | \
@@ -1002,6 +1009,8 @@ static void ixgbe_get_drvinfo(struct net_device *netdev,
 
 	strlcpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
+
+	drvinfo->n_priv_flags = IXGBE_PRIV_FLAGS_STR_LEN;
 }
 
 static void ixgbe_get_ringparam(struct net_device *netdev,
@@ -1141,6 +1150,8 @@ static int ixgbe_get_sset_count(struct net_device *netdev, int sset)
 		return IXGBE_TEST_LEN;
 	case ETH_SS_STATS:
 		return IXGBE_STATS_LEN;
+	case ETH_SS_PRIV_FLAGS:
+		return IXGBE_PRIV_FLAGS_STR_LEN;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1305,6 +1316,9 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 		}
 		/* BUG_ON(p - data != IXGBE_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
+	case ETH_SS_PRIV_FLAGS:
+		memcpy(data, ixgbe_priv_flags_strings,
+		       IXGBE_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
 	}
 }
 
@@ -3386,6 +3400,37 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
 	return 0;
 }
 
+static u32 ixgbe_get_priv_flags(struct net_device *netdev)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(netdev);
+	u32 priv_flags = 0;
+
+	if (adapter->flags2 & IXGBE_FLAG2_RX_LEGACY)
+		priv_flags |= IXGBE_PRIV_FLAGS_LEGACY_RX;
+
+	return priv_flags;
+}
+
+static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(netdev);
+	unsigned int flags2 = adapter->flags2;
+
+	flags2 &= ~IXGBE_FLAG2_RX_LEGACY;
+	if (priv_flags & IXGBE_PRIV_FLAGS_LEGACY_RX)
+		flags2 |= IXGBE_FLAG2_RX_LEGACY;
+
+	if (flags2 != adapter->flags2) {
+		adapter->flags2 = flags2;
+
+		/* reset interface to repopulate queues */
+		if (netif_running(netdev))
+			ixgbe_reinit_locked(adapter);
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.get_settings           = ixgbe_get_settings,
 	.set_settings           = ixgbe_set_settings,
@@ -3422,6 +3467,8 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
 	.set_eee		= ixgbe_set_eee,
 	.get_channels		= ixgbe_get_channels,
 	.set_channels		= ixgbe_set_channels,
+	.get_priv_flags		= ixgbe_get_priv_flags,
+	.set_priv_flags		= ixgbe_set_priv_flags,
 	.get_ts_info		= ixgbe_get_ts_info,
 	.get_module_info	= ixgbe_get_module_info,
 	.get_module_eeprom	= ixgbe_get_module_eeprom,

