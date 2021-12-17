From: Joe Damato <jdamato@fastly.com>
Date: Fri, 17 Dec 2021 11:35:15 -0800
Subject: [Intel-wired-lan] [net-queue, v2,
 1/5] i40e: Remove rx page reuse double count.
In-Reply-To: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
References: <1639769719-81285-1-git-send-email-jdamato@fastly.com>
Message-ID: <1639769719-81285-2-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Page reuse was being tracked from two locations:
  - i40e_reuse_rx_page (via 40e_clean_rx_irq), and
  - i40e_alloc_mapped_page

Remove the double count and only count reuse from i40e_alloc_mapped_page
when the page is about to be reused.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 10a83e5..8b3ffb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1382,8 +1382,6 @@ static void i40e_reuse_rx_page(struct i40e_ring *rx_ring,
 	new_buff->page_offset	= old_buff->page_offset;
 	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
 
-	rx_ring->rx_stats.page_reuse_count++;
-
 	/* clear contents of buffer_info */
 	old_buff->page = NULL;
 }
-- 
2.7.4

