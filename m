From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 Dec 2019 03:13:03 -0800
Subject: [Intel-wired-lan] [PATCH S35 11/15] ice: Demote MTU change print to
 debug
In-Reply-To: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
Message-ID: <20191212111307.33566-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Following the changes of commit 12299132b3d3 ("net: ethernet: intel: Demote
MTU change prints to debug"), change the MTU change message to netdev_dbg()

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c2811b56f569..0c10fc4c2797 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4924,7 +4924,7 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	ice_for_each_peer(pf, event, ice_peer_check_for_reg);
 
 out:
-	netdev_info(netdev, "changed MTU to %d\n", new_mtu);
+	netdev_dbg(netdev, "changed MTU to %d\n", new_mtu);
 free_event:
 	kfree(event);
 	return err;
-- 
2.20.1

