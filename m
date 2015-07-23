From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:38 -0400
Subject: [Intel-wired-lan] [next PATCH S9 09/15] i40e: Remove useless message
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

Remove a useless message that blathers on whenever a vxlan port is deleted.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: If63fb8cf38e56cf433b68e498f11389de51919ba
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b267e7a..a43062e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8028,9 +8028,6 @@ static void i40e_del_vxlan_port(struct net_device *netdev,
 		pf->vxlan_ports[idx] = 0;
 		pf->pending_vxlan_bitmap |= BIT_ULL(idx);
 		pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
-
-		dev_info(&pf->pdev->dev, "deleting vxlan port %d\n",
-			 ntohs(port));
 	} else {
 		netdev_warn(netdev, "vxlan port %d was not found, not deleting\n",
 			    ntohs(port));
-- 
1.9.3

