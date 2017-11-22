From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:59 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 08/16] ixgbe: Assume
 provided MAC filter has been verified by macvlan
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185658.29785.82075.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The macvlan driver itself will validate the MAC address that is configured
for a given interface. There is no need for us to verify it again.

Instead we should be checking to verify that we actuall allocate the filter
and have not run out of resources to configure a MAC rule in our filter
table.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 09754519a0d9..6b553f96ead9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5404,12 +5404,16 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 	if (err)
 		goto fwd_queue_err;
 
-	if (is_valid_ether_addr(vdev->dev_addr))
-		ixgbe_add_mac_filter(adapter, vdev->dev_addr,
-				     VMDQ_P(accel->pool));
+	/* ixgbe_add_mac_filter will return an index if it succeeds, so we
+	 * need to only treat it as an error value if it is negative.
+	 */
+	err = ixgbe_add_mac_filter(adapter, vdev->dev_addr,
+				   VMDQ_P(accel->pool));
+	if (err < 0)
+		goto fwd_queue_err;
 
 	ixgbe_macvlan_set_rx_mode(vdev, VMDQ_P(accel->pool), adapter);
-	return err;
+	return 0;
 fwd_queue_err:
 	ixgbe_fwd_ring_down(vdev, accel);
 	return err;

