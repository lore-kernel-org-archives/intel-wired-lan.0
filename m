From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Thu, 22 Jul 2021 17:19:31 +0200
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix ATR queue selection
Message-ID: <20210722151931.28037-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Without this patch, ATR does not work. Receive/transmit uses queue
selection based on SW DCB hashing method.

If traffic classes are not configured for PF, then use
netdev_pick_tx function for selecting queue for packet transmission.
Instead of calling i40e_swdcb_skb_tx_hash, call netdev_pick_tx,
which ensures that packet is transmitted/received from CPU that is
running the application.

Reproduction steps:
1. Load i40e driver
2. Map each MSI interrupt of i40e port for each CPU
3. Disable ntuple, enable ATR i.e.:
ethtool -K $interface ntuple off
ethtool --set-priv-flags $interface flow-director-atr
4. Run application that is generating traffic and is bound to a
single CPU, i.e.:
taskset -c 9 netperf -H 1.1.1.1 -t TCP_RR -l 10
5. Observe behavior:
Application's traffic should be restricted to the CPU provided in
taskset.

Fixes: 821bd0c990ba ("i40e: Fix queue-to-TC mapping on Tx")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v2: Improved commit message
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 3f25bd8..10a83e5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3663,8 +3663,7 @@ u16 i40e_lan_select_queue(struct net_device *netdev,
 
 	/* is DCB enabled at all? */
 	if (vsi->tc_config.numtc == 1)
-		return i40e_swdcb_skb_tx_hash(netdev, skb,
-					      netdev->real_num_tx_queues);
+		return netdev_pick_tx(netdev, skb, sb_dev);
 
 	prio = skb->priority;
 	hw = &vsi->back->hw;

base-commit: e84671cd9648eb1f2b346378c100b4ebfbd1b01c
-- 
2.18.4

