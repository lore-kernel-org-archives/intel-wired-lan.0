From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 May 2019 10:37:00 -0700
Subject: [Intel-wired-lan] [next PATCH S5 iavf 02/11] iavf: use signed
 variable
In-Reply-To: <20190514173709.62431-1-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
Message-ID: <20190514173709.62431-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The counter variable in iavf_clean_tx_irq starts out negative and climbs
to 0. So allocating it as u16 is actually a really bad idea that just
happens to work because the value underflows and overflows consistently
on most architectures.

Replace the u16 with an int so signed math works as expected.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 6d43cbe29c49..d28b57937245 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -190,7 +190,7 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 static bool iavf_clean_tx_irq(struct iavf_vsi *vsi,
 			      struct iavf_ring *tx_ring, int napi_budget)
 {
-	u16 i = tx_ring->next_to_clean;
+	int i = tx_ring->next_to_clean;
 	struct iavf_tx_buffer *tx_buf;
 	struct iavf_tx_desc *tx_desc;
 	unsigned int total_bytes = 0, total_packets = 0;
-- 
2.19.2

