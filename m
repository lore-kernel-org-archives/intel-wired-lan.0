From: Marek Majtyka <alardam@gmail.com>
Date: Tue,  8 Sep 2020 14:34:40 +0200
Subject: [Intel-wired-lan] [PATCH net-next] i40e: remove redundant assigment
Message-ID: <20200908123440.11278-1-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove a redundant assigment of the software ring pointer in the i40e
driver. The variable is assigned twice with no use in between, so just
get rid of the first occurrence.

Fixes: 3b4f0b66c2b3 ("i40e, xsk: Migrate to new MEM_TYPE_XSK_BUFF_POOL")
Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 2a1153d8957b..8661f461f620 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -306,7 +306,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 			continue;
 		}
 
-		bi = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
 		size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
 		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
 		if (!size)
-- 
2.20.1

