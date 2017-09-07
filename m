From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:48 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 03/11] i40e/i40evf: fix
	incorrect default ITR values on driver load
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The ITR register expects to be programmed in units of 2 microseconds.
Because of this, all of the drivers I40E_ITR_* constants are in terms of
this 2 microsecond register.

Unfortunately, the rx_itr_default value is expected to be programmed in
microseconds.

Effectively the driver defaults to an ITR value of half the expected
value (in terms of minimum microseconds between interrupts).

Fix this by changing the default values to be calculated using
ITR_REG_TO_USEC macro which indicates that we're converting from the
register units into microseconds.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h     | 6 ++++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 6 ++++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 76b03f7..cc5327c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8983,8 +8983,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		    I40E_FLAG_MSIX_ENABLED;
 
 	/* Set default ITR */
-	pf->rx_itr_default = I40E_ITR_DYNAMIC | I40E_ITR_RX_DEF;
-	pf->tx_itr_default = I40E_ITR_DYNAMIC | I40E_ITR_TX_DEF;
+	pf->rx_itr_default = I40E_ITR_RX_DEF;
+	pf->tx_itr_default = I40E_ITR_TX_DEF;
 
 	/* Depending on PF configurations, it is possible that the RSS
 	 * maximum might end up larger than the available queues
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index a4e3e66..c3156aa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -38,8 +38,10 @@
 #define I40E_ITR_8K                0x003E
 #define I40E_ITR_4K                0x007A
 #define I40E_MAX_INTRL             0x3B    /* reg uses 4 usec resolution */
-#define I40E_ITR_RX_DEF            I40E_ITR_20K
-#define I40E_ITR_TX_DEF            I40E_ITR_20K
+#define I40E_ITR_RX_DEF            (ITR_REG_TO_USEC(I40E_ITR_20K) | \
+				    I40E_ITR_DYNAMIC)
+#define I40E_ITR_TX_DEF            (ITR_REG_TO_USEC(I40E_ITR_20K) | \
+				    I40E_ITR_DYNAMIC)
 #define I40E_ITR_DYNAMIC           0x8000  /* use top bit as a flag */
 #define I40E_MIN_INT_RATE          250     /* ~= 1000000 / (I40E_MAX_ITR * 2) */
 #define I40E_MAX_INT_RATE          500000  /* == 1000000 / (I40E_MIN_ITR * 2) */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index d8ca802..8f9830d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -38,8 +38,10 @@
 #define I40E_ITR_8K                0x003E
 #define I40E_ITR_4K                0x007A
 #define I40E_MAX_INTRL             0x3B    /* reg uses 4 usec resolution */
-#define I40E_ITR_RX_DEF            I40E_ITR_20K
-#define I40E_ITR_TX_DEF            I40E_ITR_20K
+#define I40E_ITR_RX_DEF            (ITR_REG_TO_USEC(I40E_ITR_20K) | \
+				    I40E_ITR_DYNAMIC)
+#define I40E_ITR_TX_DEF            (ITR_REG_TO_USEC(I40E_ITR_20K) | \
+				    I40E_ITR_DYNAMIC)
 #define I40E_ITR_DYNAMIC           0x8000  /* use top bit as a flag */
 #define I40E_MIN_INT_RATE          250     /* ~= 1000000 / (I40E_MAX_ITR * 2) */
 #define I40E_MAX_INT_RATE          500000  /* == 1000000 / (I40E_MIN_ITR * 2) */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4496c48..d621daa 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1223,7 +1223,7 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 		tx_ring->netdev = adapter->netdev;
 		tx_ring->dev = &adapter->pdev->dev;
 		tx_ring->count = adapter->tx_desc_count;
-		tx_ring->tx_itr_setting = (I40E_ITR_DYNAMIC | I40E_ITR_TX_DEF);
+		tx_ring->tx_itr_setting = I40E_ITR_TX_DEF;
 		if (adapter->flags & I40EVF_FLAG_WB_ON_ITR_CAPABLE)
 			tx_ring->flags |= I40E_TXR_FLAGS_WB_ON_ITR;
 
@@ -1232,7 +1232,7 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 		rx_ring->netdev = adapter->netdev;
 		rx_ring->dev = &adapter->pdev->dev;
 		rx_ring->count = adapter->rx_desc_count;
-		rx_ring->rx_itr_setting = (I40E_ITR_DYNAMIC | I40E_ITR_RX_DEF);
+		rx_ring->rx_itr_setting = I40E_ITR_RX_DEF;
 	}
 
 	adapter->num_active_queues = num_active_queues;
-- 
2.9.4

