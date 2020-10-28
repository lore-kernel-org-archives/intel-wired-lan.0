From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 28 Oct 2020 13:19:42 -0700
Subject: [Intel-wired-lan] [PATCH v2 09/10] igc: Add support for
 XDP_REDIRECT action
In-Reply-To: <20201028201943.93147-1-andre.guedes@intel.com>
References: <20201028201943.93147-1-andre.guedes@intel.com>
Message-ID: <20201028201943.93147-10-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds support for the XDP_REDIRECT action which enables XDP
programs to redirect packets arriving at I225 NIC.

The patch also tweaks the driver's page counting scheme (as described
in '8ce29c679a6e i40e: tweak page counting for XDP_REDIRECT' and
implemented by other Intel drivers) in order to properly support
XDP_REDIRECT action.

This patch has been tested with the sample apps "xdp_redirect_cpu" and
"xdp_redirect_map" located in samples/bpf/.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 11 ++++++++---
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  6 ++++++
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7bcfc72b00fc..f9c7bbc1347e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1710,8 +1710,8 @@ static bool igc_can_reuse_rx_page(struct igc_rx_buffer *rx_buffer)
 	 * the pagecnt_bias and page count so that we fully restock the
 	 * number of references the driver holds.
 	 */
-	if (unlikely(!pagecnt_bias)) {
-		page_ref_add(page, USHRT_MAX);
+	if (unlikely(pagecnt_bias == 1)) {
+		page_ref_add(page, USHRT_MAX - 1);
 		rx_buffer->pagecnt_bias = USHRT_MAX;
 	}
 
@@ -1852,7 +1852,8 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
 	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = igc_rx_offset(rx_ring);
-	bi->pagecnt_bias = 1;
+	page_ref_add(page, USHRT_MAX - 1);
+	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -1952,6 +1953,9 @@ static void igc_finalize_xdp(struct igc_adapter *adapter, int status)
 		igc_flush_tx_descriptors(ring);
 		__netif_tx_unlock(nq);
 	}
+
+	if (status & IGC_XDP_REDIRECT)
+		xdp_do_flush();
 }
 
 static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
@@ -2020,6 +2024,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 				rx_buffer->pagecnt_bias++;
 				break;
 			case IGC_XDP_TX:
+			case IGC_XDP_REDIRECT:
 				igc_rx_buffer_flip(rx_buffer, truesize);
 				xdp_status |= xdp_res;
 				break;
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 17852cc3a438..39b8310dfba1 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -151,6 +151,12 @@ struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
 		else
 			res = IGC_XDP_TX;
 		break;
+	case XDP_REDIRECT:
+		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
+			res = IGC_XDP_CONSUMED;
+		else
+			res = IGC_XDP_REDIRECT;
+		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.h b/drivers/net/ethernet/intel/igc/igc_xdp.h
index fdb31f40dbe5..1c38a80c3aa0 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.h
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.h
@@ -7,6 +7,7 @@
 #define IGC_XDP_PASS		0
 #define IGC_XDP_CONSUMED	BIT(0)
 #define IGC_XDP_TX		BIT(1)
+#define IGC_XDP_REDIRECT	BIT(2)
 
 int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 		     struct netlink_ext_ack *extack);
-- 
2.28.0

