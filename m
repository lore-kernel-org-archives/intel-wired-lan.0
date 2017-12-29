From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:48:33 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 01/14] i40e: fix typo in
 function description
Message-ID: <20171229134833.14139-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

'bufer' should be 'buffer'

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2a492ec..95c2aaf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1980,7 +1980,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
  * @rx_buffer: rx buffer to pull data from
  *
  * This function will clean up the contents of the rx_buffer.  It will
- * either recycle the bufer or unmap it and free the associated resources.
+ * either recycle the buffer or unmap it and free the associated resources.
  */
 static void i40e_put_rx_buffer(struct i40e_ring *rx_ring,
 			       struct i40e_rx_buffer *rx_buffer)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index c7831f7..ae6dd90 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1274,7 +1274,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
  * @rx_buffer: rx buffer to pull data from
  *
  * This function will clean up the contents of the rx_buffer.  It will
- * either recycle the bufer or unmap it and free the associated resources.
+ * either recycle the buffer or unmap it and free the associated resources.
  */
 static void i40e_put_rx_buffer(struct i40e_ring *rx_ring,
 			       struct i40e_rx_buffer *rx_buffer)
-- 
2.9.5

