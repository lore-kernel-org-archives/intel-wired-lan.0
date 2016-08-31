From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 31 Aug 2016 10:34:28 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Return error when getting PHY
 address if PHY access is not supported
Message-ID: <147266486833.85990.11581043019718532911.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In cases where PHY register access is not supported, don't mislead
a caller into thinking that it is supported by returning a PHY
address. Instead, return -EOPNOTSUPP when PHY access is not
supported.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1c888588cecd..9081b2ecb949 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8008,6 +8008,10 @@ static int ixgbe_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
 		return ixgbe_ptp_set_ts_config(adapter, req);
 	case SIOCGHWTSTAMP:
 		return ixgbe_ptp_get_ts_config(adapter, req);
+	case SIOCGMIIPHY:
+		if (!adapter->hw.phy.ops.read_reg)
+			return -EOPNOTSUPP;
+		/* fall through */
 	default:
 		return mdio_mii_ioctl(&adapter->hw.phy.mdio, if_mii(req), cmd);
 	}

