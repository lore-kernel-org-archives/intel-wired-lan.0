From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:18 -0700
Subject: [Intel-wired-lan] [next PATCH S36 10/12] i40e/i40evf: properly
	report rx packet hash
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-11-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This logic is inverted. If the RXHASH flag is set, then we should go
ahead and call skb_set_hash.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ib2e30356dced1d3e939c8061ab6ad5bd94197e7c
---
Testing Hints : Not sure how to test this without instrumenting the
driver.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 6b18c8a..a5def20 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1412,7 +1412,7 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
 		cpu_to_le64((u64)I40E_RX_DESC_FLTSTAT_RSS_HASH <<
 			    I40E_RX_DESC_STATUS_FLTSTAT_SHIFT);
 
-	if (ring->netdev->features & NETIF_F_RXHASH)
+	if (!(ring->netdev->features & NETIF_F_RXHASH))
 		return;
 
 	if ((rx_desc->wb.qword1.status_error_len & rss_mask) == rss_mask) {
-- 
2.4.11

