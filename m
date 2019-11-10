From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 10 Nov 2019 17:57:44 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Remove excess parameter
 description from igc_is_non_eop
Message-ID: <20191110155744.13755-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The function description for igc_is_non_eop includes an extra @skb
parameter description. This parameter doesn't exist on the function, so
remove it.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index de8e4b570fa6..ac420a9b4d2b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1485,7 +1485,6 @@ static bool igc_can_reuse_rx_page(struct igc_rx_buffer *rx_buffer)
  * igc_is_non_eop - process handling of non-EOP buffers
  * @rx_ring: Rx ring being processed
  * @rx_desc: Rx descriptor for current buffer
- * @skb: current socket buffer containing buffer in progress
  *
  * This function updates next to clean.  If the buffer is an EOP buffer
  * this function exits returning false, otherwise it will place the
-- 
2.11.0

