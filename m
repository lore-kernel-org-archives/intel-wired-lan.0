From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 05 Jun 2018 11:11:14 -0400
Subject: [Intel-wired-lan] [net-queue PATCH 2/2] ixgbe: Fix bit definitions
 and add support for testing for ipsec support
In-Reply-To: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
References: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180605151113.3359.74309.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch addresses two issues. First it adds the correct bit definitions
for the SECTXSTAT and SECRXSTAT registers. Then it makes use of those
definitions to test for if ipsec has been disabled on the part and if so we
do not enable it.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |   14 +++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    6 ++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 7b23fb0..4b242c0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -975,10 +975,22 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
  **/
 void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
 {
+	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_ipsec *ipsec;
+	u32 t_dis, r_dis;
 	size_t size;
 
-	if (adapter->hw.mac.type == ixgbe_mac_82598EB)
+	if (hw->mac.type == ixgbe_mac_82598EB)
+		return;
+
+	/* If there is no support for either Tx or Rx offload
+	 * we should not be advertising support for ipsec.
+	 */
+	t_dis = IXGBE_READ_REG(hw, IXGBE_SECTXSTAT) &
+		IXGBE_SECTXSTAT_SECTX_OFF_DIS;
+	r_dis = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT) &
+		IXGBE_SECRXSTAT_SECRX_OFF_DIS;
+	if (t_dis || r_dis)
 		return;
 
 	ipsec = kzalloc(sizeof(*ipsec), GFP_KERNEL);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index e8ed377..3d54746 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -599,13 +599,15 @@ struct ixgbe_nvm_version {
 #define IXGBE_SECTXCTRL_STORE_FORWARD   0x00000004
 
 #define IXGBE_SECTXSTAT_SECTX_RDY       0x00000001
-#define IXGBE_SECTXSTAT_ECC_TXERR       0x00000002
+#define IXGBE_SECTXSTAT_SECTX_OFF_DIS	0x00000002
+#define IXGBE_SECTXSTAT_ECC_TXERR       0x00000004
 
 #define IXGBE_SECRXCTRL_SECRX_DIS       0x00000001
 #define IXGBE_SECRXCTRL_RX_DIS          0x00000002
 
 #define IXGBE_SECRXSTAT_SECRX_RDY       0x00000001
-#define IXGBE_SECRXSTAT_ECC_RXERR       0x00000002
+#define IXGBE_SECRXSTAT_SECRX_OFF_DIS	0x00000002
+#define IXGBE_SECRXSTAT_ECC_RXERR       0x00000004
 
 /* LinkSec (MacSec) Registers */
 #define IXGBE_LSECTXCAP         0x08A00

