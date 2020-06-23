From: Ciara Loftus <ciara.loftus@intel.com>
Date: Tue, 23 Jun 2020 13:06:55 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] i40e: add xdp ring
 statistics to vsi stats
Message-ID: <20200623130657.5668-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Prior to this, only rx and tx ring statistics were accounted for.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5d807c8004f8..13aef0e51c24 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -811,6 +811,25 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 		rx_p += packets;
 		rx_buf += p->rx_stats.alloc_buff_failed;
 		rx_page += p->rx_stats.alloc_page_failed;
+
+		if (i40e_enabled_xdp_vsi(vsi)) {
+			/* locate xdp ring */
+			p = READ_ONCE(vsi->xdp_rings[q]);
+			if (!p)
+				continue;
+
+			do {
+				start = u64_stats_fetch_begin_irq(&p->syncp);
+				packets = p->stats.packets;
+				bytes = p->stats.bytes;
+			} while (u64_stats_fetch_retry_irq(&p->syncp, start));
+			tx_b += bytes;
+			tx_p += packets;
+			tx_restart += p->tx_stats.restart_queue;
+			tx_busy += p->tx_stats.tx_busy;
+			tx_linearize += p->tx_stats.tx_linearize;
+			tx_force_wb += p->tx_stats.tx_force_wb;
+		}
 	}
 	rcu_read_unlock();
 	vsi->tx_restart = tx_restart;
-- 
2.17.1

