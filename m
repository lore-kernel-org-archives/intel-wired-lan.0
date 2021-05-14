From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 13 May 2021 17:31:04 -0700
Subject: [Intel-wired-lan] [PATCH net-queue v1 2/2] igb: Fix user-after-free
 error during reset
In-Reply-To: <20210514003104.1360697-1-vinicius.gomes@intel.com>
References: <20210514003104.1360697-1-vinicius.gomes@intel.com>
Message-ID: <20210514003104.1360697-2-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Cleans the next descriptor to watch (next_to_watch) when cleaning the
TX ring.

Failure to do so can cause invalid memory accesses. If igc_poll() runs
while the controller is reset this can lead to the driver try to free
a skb that was already freed.

(The crash is harder to reproduce with the igb driver, but the same
potential problem exists as the code is identical to igc)

Fixes: 7cc6fd4c60f2 ("igb: Don't bother clearing Tx buffer_info in igb_clean_tx_ring")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reported-by: Erez Geva <erez.geva.ext@siemens.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fb3d69586db7..7d1b97f1deef 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4841,6 +4841,8 @@ static void igb_clean_tx_ring(struct igb_ring *tx_ring)
 					       DMA_TO_DEVICE);
 		}
 
+		tx_buffer->next_to_watch = NULL;
+
 		/* move us one more past the eop_desc for start of next pkt */
 		tx_buffer++;
 		i++;
-- 
2.31.1

