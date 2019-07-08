From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:28 -0700
Subject: [Intel-wired-lan] [PATCH 11/19] fm10k: reduce scope of the ring
 variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-12-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the ring local variable in the fm10k_assign_l2_accel
function.

This was detected by cppcheck and resolves the following warning
produced by that tool:

[fm10k_netdev.c:1447]: (style) The scope of the variable 'ring' can be
reduced.

Change-Id: Ia2f2bc0cabed02c65f513e9917bc1859d5cc414c
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Title: fm10k: reduce scope of the ring variable
Change-type: ImplementationChange
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index c73fb38be678..259da075093f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1444,11 +1444,11 @@ static int __fm10k_setup_tc(struct net_device *dev, enum tc_setup_type type,
 static void fm10k_assign_l2_accel(struct fm10k_intfc *interface,
 				  struct fm10k_l2_accel *l2_accel)
 {
-	struct fm10k_ring *ring;
 	int i;
 
 	for (i = 0; i < interface->num_rx_queues; i++) {
-		ring = interface->rx_ring[i];
+		struct fm10k_ring *ring = interface->rx_ring[i];
+
 		rcu_assign_pointer(ring->l2_accel, l2_accel);
 	}
 
-- 
2.22.0.214.g8dca754b1e87

