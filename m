From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 02 Nov 2017 16:33:30 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 1/5] ixgbe: Fix
 interaction between SR-IOV and macvlan offload
In-Reply-To: <20171102232857.15146.21583.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
Message-ID: <20171102233315.15146.95215.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

When SR-IOV was enabled the macvlan offload was configuring several filters
with the wrong pool value. This would result in the macvlan interfaces not
being able to receive traffic that had to pass over the physical interface.

To fix it wrap the pool argument in the VMDQ_P macro which will add the
necessary offset to get to the actual VMDq pool

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2d0232254a7a..69ef35d13c36 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5426,10 +5426,11 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 		goto fwd_queue_err;
 
 	if (is_valid_ether_addr(vdev->dev_addr))
-		ixgbe_add_mac_filter(adapter, vdev->dev_addr, accel->pool);
+		ixgbe_add_mac_filter(adapter, vdev->dev_addr,
+				     VMDQ_P(accel->pool));
 
 	ixgbe_fwd_psrtype(accel);
-	ixgbe_macvlan_set_rx_mode(vdev, accel->pool, adapter);
+	ixgbe_macvlan_set_rx_mode(vdev, VMDQ_P(accel->pool), adapter);
 	return err;
 fwd_queue_err:
 	ixgbe_fwd_ring_down(vdev, accel);

