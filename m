From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 23 Jul 2018 09:01:30 -0700
Subject: [Intel-wired-lan] e1000: ensure to free old tx/rx rings in
 set_ringparam()
In-Reply-To: <20180723160130.8911-1-jeffrey.t.kirsher@intel.com>
References: <20180723160130.8911-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180723160130.8911-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bo Chen <chenbo@pdx.edu>

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new value
and the old tx/rx rings are freed only when the device is up. There are resource
leaks on old tx/rx rings when the device is not up. This bug is reported by COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index bdb3f8e65ed4..27b006b60f8b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -624,14 +624,14 @@ static int e1000_set_ringparam(struct net_device *netdev,
 		adapter->tx_ring = tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring = rxdr;
 		adapter->tx_ring = txdr;
 		err = e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
 
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;
