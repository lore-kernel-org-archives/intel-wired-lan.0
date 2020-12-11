From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 11 Dec 2020 17:49:56 +0100
Subject: [Intel-wired-lan] [PATCH net-next 8/8] i40e,
 xsk: Simplify the do-while allocation loop
In-Reply-To: <20201211164956.59628-1-maciej.fijalkowski@intel.com>
References: <20201211164956.59628-1-maciej.fijalkowski@intel.com>
Message-ID: <20201211164956.59628-9-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Fold the count decrement into the while-statement.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index bfa84bfb0488..679200d94ef8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -215,9 +215,7 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 			bi = i40e_rx_bi(rx_ring, 0);
 			ntu = 0;
 		}
-
-		count--;
-	} while (count);
+	} while (--count);
 
 no_buffers:
 	if (rx_ring->next_to_use != ntu)
-- 
2.20.1

