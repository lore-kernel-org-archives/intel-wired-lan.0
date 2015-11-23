From: Vasu Dev <vasu.dev@intel.com>
Date: Mon, 23 Nov 2015 10:31:01 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: use correct fcoe ddp max check
Message-ID: <20151123183101.18641.30146.stgit@lin-nd1-054.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use fcoe_ddp_xid from netdev as this is correctly set for different
device IDs to avoid DDP skip error on X550 as "xid=0x20b out-of-range"

Signed-off-by: Vasu Dev <vasu.dev@intel.com>
---

 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 631c603..83ccb7b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -77,7 +77,7 @@ int ixgbe_fcoe_ddp_put(struct net_device *netdev, u16 xid)
 	if (!netdev)
 		return 0;
 
-	if (xid >= IXGBE_FCOE_DDP_MAX)
+	if (xid >= netdev->fcoe_ddp_xid)
 		return 0;
 
 	adapter = netdev_priv(netdev);
@@ -177,7 +177,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 		return 0;
 
 	adapter = netdev_priv(netdev);
-	if (xid >= IXGBE_FCOE_DDP_MAX) {
+	if (xid >= netdev->fcoe_ddp_xid) {
 		e_warn(drv, "xid=0x%x out-of-range\n", xid);
 		return 0;
 	}

