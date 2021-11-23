From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 23 Nov 2021 18:18:33 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/9] e1000: switch to
 napi_build_skb()
In-Reply-To: <20211123171840.157471-1-alexandr.lobakin@intel.com>
References: <20211123171840.157471-1-alexandr.lobakin@intel.com>
Message-ID: <20211123171840.157471-3-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

napi_build_skb() reuses per-cpu NAPI skbuff_head cache in order
to save some cycles on freeing/allocating skbuff_heads on every
new Rx or completed Tx element.
e1000 driver runs Tx completion polling cycle right before the Rx
one. Now that e1000 uses napi_consume_skb() to put skbuff_heads of
completed entries into the cache, it will never empty and always
warm at that moment. Switch to the napi_build_skb() to relax mm
pressure on heavy Rx and increase throughput.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 975a145d48ef..3f5feb55cfba 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -4384,7 +4384,7 @@ static bool e1000_clean_rx_irq(struct e1000_adapter *adapter,
 		if (!skb) {
 			unsigned int frag_len = e1000_frag_len(adapter);

-			skb = build_skb(data - E1000_HEADROOM, frag_len);
+			skb = napi_build_skb(data - E1000_HEADROOM, frag_len);
 			if (!skb) {
 				adapter->alloc_rx_buff_failed++;
 				break;
--
2.33.1

