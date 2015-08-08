From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:19:09 -0700
Subject: [Intel-wired-lan] [PATCH V5 17/19] ixgbe: Add small packet padding
	support for X550
In-Reply-To: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150808231909.94784.6484.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch sets RDRXCTL.PSP when the driver is in SRIOV mode which
enables padding of small packets.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index eecd70b170f3..0ec2cd841be0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3804,6 +3804,9 @@ static void ixgbe_setup_rdrxctl(struct ixgbe_adapter *adapter)
 		break;
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+		if (adapter->num_vfs)
+			rdrxctl |= IXGBE_RDRXCTL_PSP;
+		/* fall through for older HW */
 	case ixgbe_mac_82599EB:
 	case ixgbe_mac_X540:
 		/* Disable RSC for ACK packets */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 998cfb915ad7..939c90c4ff39 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1193,6 +1193,7 @@ struct ixgbe_thermal_sensor_data {
 /* RDRXCTL Bit Masks */
 #define IXGBE_RDRXCTL_RDMTS_1_2     0x00000000 /* Rx Desc Min Threshold Size */
 #define IXGBE_RDRXCTL_CRCSTRIP      0x00000002 /* CRC Strip */
+#define IXGBE_RDRXCTL_PSP           0x00000004 /* Pad small packet */
 #define IXGBE_RDRXCTL_MVMEN         0x00000020
 #define IXGBE_RDRXCTL_DMAIDONE      0x00000008 /* DMA init cycle done */
 #define IXGBE_RDRXCTL_AGGDIS        0x00010000 /* Aggregation disable */

