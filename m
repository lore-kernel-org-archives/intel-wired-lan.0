From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Sun, 14 May 2017 19:56:49 +0200
Subject: [Intel-wired-lan] [PATCH net] i40e: proper update of the
	page_offset field
Message-ID: <20170514175649.31616-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

In f8b45b74cc62 ("i40e/i40evf: Use build_skb to build frames")
i40e_build_skb updates the page_offset field with an incorrect offset,
which can lead to data corruption. This patch updates page_offset
correctly.

Note that the bug only appears on architectures where PAGE_SIZE is
8192 or larger.

Fixes: f8b45b74cc62 ("i40e/i40evf: Use build_skb to build frames")
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 29321a6167a6..cd894f4023b1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1854,7 +1854,8 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = SKB_DATA_ALIGN(size);
+	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
+				SKB_DATA_ALIGN(I40E_SKB_PAD + size);
 #endif
 	struct sk_buff *skb;
 
-- 
2.11.0

