From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 16 Jan 2018 14:27:19 -0500
Subject: [Intel-wired-lan] [net-queue PATCH] i40e/i40evf: Update DESC_NEEDED
 value to reflect larger value
Message-ID: <20180116192719.11191.21193.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When compared to ixgbe and other previous Intel drivers the i40e and i40evf
drivers actually reserve 2 additional descriptors in maybe_stop_tx for
cache line alignment. We need to update DESC_NEEDED to reflect this as
otherwise we are more likely to return TX_BUSY which will cause issues with
things like xmit_more.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |    2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 0f5a5a9..9e94593 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -284,7 +284,7 @@ static inline unsigned int i40e_txd_use_count(unsigned int size)
 }
 
 /* Tx Descriptors needed, worst case */
-#define DESC_NEEDED (MAX_SKB_FRAGS + 4)
+#define DESC_NEEDED (MAX_SKB_FRAGS + 6)
 #define I40E_MIN_DESC_PENDING	4
 
 #define I40E_TX_FLAGS_HW_VLAN		BIT(1)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 54af658..c855553 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -264,7 +264,7 @@ static inline unsigned int i40e_txd_use_count(unsigned int size)
 }
 
 /* Tx Descriptors needed, worst case */
-#define DESC_NEEDED (MAX_SKB_FRAGS + 4)
+#define DESC_NEEDED (MAX_SKB_FRAGS + 6)
 #define I40E_MIN_DESC_PENDING	4
 
 #define I40E_TX_FLAGS_HW_VLAN		BIT(1)

