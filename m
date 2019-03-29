From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 15:08:34 -0700
Subject: [Intel-wired-lan] [next PATCH S4 05/11] i40e: fix wrapping around
 netif_set_real_num_tx_queues
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <20190329220840.51187-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

After total number of queues are updated under heavy traffic with
ethtool -L command, the driver may receive few skbuffs with
queue_mapping value greater than new total number of queues causing
kernel panic.

This fix flushes all skbs after netif_set_real_num_tx_queues call
while reconfiguring total tx queues. This helps in avoiding skbs
with invalid queue_mapping.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index af0670ea940e..a3b225502f23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8223,6 +8223,8 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
 		if (err)
 			goto err_set_queues;
 
+		qdisc_reset_all_tx(vsi->netdev);
+
 		err = netif_set_real_num_rx_queues(vsi->netdev,
 						   vsi->num_queue_pairs);
 		if (err)
-- 
2.19.2

