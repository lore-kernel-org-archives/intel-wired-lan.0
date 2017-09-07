From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:52 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 07/11] i40e/i40evf: bundle
	more descriptors when allocating buffers
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Double the number of descriptors we'll bundle into one tail bump when
receiving. Empirical testing has shown that we reduce CPU utilization
and don't appear to reduce throughput or packet rate. 32 seems to be the
sweet spot, as it's half the default polling budget, so we'd essentially
reduce from 4 tail writes when polling down to 2. Increasing this up to
64 appears to have negative impacts as it may become possible that we
don't bump the tail each time we get polled, which could cause a long
delay between returning descriptors to the hardware.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index c3156aa..ff57ae4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -208,7 +208,7 @@ static inline bool i40e_test_staterr(union i40e_rx_desc *rx_desc,
 }
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
-#define I40E_RX_BUFFER_WRITE	16	/* Must be power of 2 */
+#define I40E_RX_BUFFER_WRITE	32	/* Must be power of 2 */
 #define I40E_RX_INCREMENT(r, i) \
 	do {					\
 		(i)++;				\
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 8f9830d..8d26c85 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -191,7 +191,7 @@ static inline bool i40e_test_staterr(union i40e_rx_desc *rx_desc,
 }
 
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
-#define I40E_RX_BUFFER_WRITE	16	/* Must be power of 2 */
+#define I40E_RX_BUFFER_WRITE	32	/* Must be power of 2 */
 #define I40E_RX_INCREMENT(r, i) \
 	do {					\
 		(i)++;				\
-- 
2.9.4

