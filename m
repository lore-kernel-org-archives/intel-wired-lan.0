From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 24 Jun 2018 22:11:13 +0800
Subject: [Intel-wired-lan] [RFC PATCH] igc: igc_free_tx_resources() can be
 static
In-Reply-To: <20180624084508.10153-1-sasha.neftin@intel.com>
References: <20180624084508.10153-1-sasha.neftin@intel.com>
Message-ID: <20180624141113.GA93760@lkp-hsx03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 6ae8ddd68f6a ("igc: Add support for Tx/Rx rings")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 igc_main.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a147a1b..78370abc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -140,7 +140,7 @@ static void igc_get_hw_control(struct igc_adapter *adapter)
  *
  *  Free all transmit software resources
  **/
-void igc_free_tx_resources(struct igc_ring *tx_ring)
+static void igc_free_tx_resources(struct igc_ring *tx_ring)
 {
 	igc_clean_tx_ring(tx_ring);
 
@@ -171,8 +171,8 @@ static void igc_free_all_tx_resources(struct igc_adapter *adapter)
 		igc_free_tx_resources(adapter->tx_ring[i]);
 }
 
-void igc_unmap_and_free_tx_resource(struct igc_ring *ring,
-				    struct igc_tx_buffer *tx_buffer)
+static void igc_unmap_and_free_tx_resource(struct igc_ring *ring,
+					   struct igc_tx_buffer *tx_buffer)
 {
 	if (tx_buffer->skb) {
 		dev_kfree_skb_any(tx_buffer->skb);
@@ -230,7 +230,7 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
  *
  *  Return 0 on success, negative on failure
  **/
-int igc_setup_tx_resources(struct igc_ring *tx_ring)
+static int igc_setup_tx_resources(struct igc_ring *tx_ring)
 {
 	struct device *dev = tx_ring->dev;
 	int size = 0;
@@ -292,7 +292,7 @@ static int igc_setup_all_tx_resources(struct igc_adapter *adapter)
  *  igc_clean_rx_ring - Free Rx Buffers per Queue
  *  @rx_ring: ring to free buffers from
  **/
-void igc_clean_rx_ring(struct igc_ring *rx_ring)
+static void igc_clean_rx_ring(struct igc_ring *rx_ring)
 {
 	u16 i = rx_ring->next_to_clean;
 
@@ -338,7 +338,7 @@ void igc_clean_rx_ring(struct igc_ring *rx_ring)
  *
  *  Free all receive software resources
  **/
-void igc_free_rx_resources(struct igc_ring *rx_ring)
+static void igc_free_rx_resources(struct igc_ring *rx_ring)
 {
 	igc_clean_rx_ring(rx_ring);
 
@@ -375,7 +375,7 @@ static void igc_free_all_rx_resources(struct igc_adapter *adapter)
  *
  *  Returns 0 on success, negative on failure
  **/
-int igc_setup_rx_resources(struct igc_ring *rx_ring)
+static int igc_setup_rx_resources(struct igc_ring *rx_ring)
 {
 	struct device *dev = rx_ring->dev;
 	int size, desc_len;
@@ -449,8 +449,8 @@ static u32 igc_tx_wthresh(struct igc_adapter *adapter)
  *
  *  Configure the Rx unit of the MAC after a reset.
  **/
-void igc_configure_rx_ring(struct igc_adapter *adapter,
-			   struct igc_ring *ring)
+static void igc_configure_rx_ring(struct igc_adapter *adapter,
+				  struct igc_ring *ring)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	union e1000_adv_rx_desc *rx_desc;
@@ -529,8 +529,8 @@ static void igc_configure_rx(struct igc_adapter *adapter)
  *
  *  Configure a transmit ring after a reset.
  **/
-void igc_configure_tx_ring(struct igc_adapter *adapter,
-			   struct igc_ring *ring)
+static void igc_configure_tx_ring(struct igc_adapter *adapter,
+				  struct igc_ring *ring)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 txdctl = 0;
@@ -586,7 +586,7 @@ static void igc_setup_mrqc(struct igc_adapter *adapter)
  *  igc_setup_rctl - configure the receive control registers
  *  @adapter: Board private structure
  **/
-void igc_setup_rctl(struct igc_adapter *adapter)
+static void igc_setup_rctl(struct igc_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 rctl;
@@ -634,7 +634,7 @@ void igc_setup_rctl(struct igc_adapter *adapter)
  *  igc_setup_tctl - configure the transmit control registers
  *  @adapter: Board private structure
  **/
-void igc_setup_tctl(struct igc_adapter *adapter)
+static void igc_setup_tctl(struct igc_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tctl;
@@ -736,7 +736,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
  *  igc_alloc_rx_buffers - Replace used receive buffers; packet split
  *  @adapter: address of board private structure
  **/
-void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
+static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
 {
 	union e1000_adv_rx_desc *rx_desc;
 	struct igc_rx_buffer *bi;
