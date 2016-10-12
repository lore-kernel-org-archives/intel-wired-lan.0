From: David Ahern <dsa@cumulusnetworks.com>
Date: Wed, 12 Oct 2016 13:51:59 -0700
Subject: [Intel-wired-lan] [PATCH net-next 11/11] net: dev: Improve debug
	statements for adjacency tracking
In-Reply-To: <1476305519-28833-1-git-send-email-dsa@cumulusnetworks.com>
References: <1476305519-28833-1-git-send-email-dsa@cumulusnetworks.com>
Message-ID: <1476305519-28833-12-git-send-email-dsa@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Adjacency code only has debugs for the insert case. Add debugs for
the remove path and make both consistently worded to make it easier
to follow the insert and removal with reference counts.

In addition, change the BUG to a WARN_ON. A missing adjacency at
removal time is not cause for a panic.

Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
---
 net/core/dev.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 52e70a3d61a4..ad5e7bfda403 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5700,6 +5700,9 @@ static int __netdev_adjacent_dev_insert(struct net_device *dev,
 
 	if (adj) {
 		adj->ref_nr += 1;
+		pr_debug("Insert adjacency: dev %s adj_dev %s adj->ref_nr %d\n",
+			 dev->name, adj_dev->name, adj->ref_nr);
+
 		return 0;
 	}
 
@@ -5713,8 +5716,8 @@ static int __netdev_adjacent_dev_insert(struct net_device *dev,
 	adj->private = private;
 	dev_hold(adj_dev);
 
-	pr_debug("dev_hold for %s, because of link added from %s to %s\n",
-		 adj_dev->name, dev->name, adj_dev->name);
+	pr_debug("Insert adjacency: dev %s adj_dev %s adj->ref_nr %d; dev_hold on %s\n",
+		 dev->name, adj_dev->name, adj->ref_nr, adj_dev->name);
 
 	if (netdev_adjacent_is_neigh_list(dev, adj_dev, dev_list)) {
 		ret = netdev_adjacent_sysfs_add(dev, adj_dev, dev_list);
@@ -5753,17 +5756,22 @@ static void __netdev_adjacent_dev_remove(struct net_device *dev,
 {
 	struct netdev_adjacent *adj;
 
+	pr_debug("Remove adjacency: dev %s adj_dev %s ref_nr %d\n",
+		 dev->name, adj_dev->name, ref_nr);
+
 	adj = __netdev_find_adj(adj_dev, dev_list);
 
 	if (!adj) {
-		pr_err("tried to remove device %s from %s\n",
+		pr_err("Adjacency does not exist for device %s from %s\n",
 		       dev->name, adj_dev->name);
-		BUG();
+		WARN_ON(1);
+		return;
 	}
 
 	if (adj->ref_nr > ref_nr) {
-		pr_debug("%s to %s ref_nr-%d = %d\n", dev->name, adj_dev->name,
-			 ref_nr, adj->ref_nr-ref_nr);
+		pr_debug("adjacency: %s to %s ref_nr - %d = %d\n",
+			 dev->name, adj_dev->name, ref_nr,
+			 adj->ref_nr - ref_nr);
 		adj->ref_nr -= ref_nr;
 		return;
 	}
@@ -5775,7 +5783,7 @@ static void __netdev_adjacent_dev_remove(struct net_device *dev,
 		netdev_adjacent_sysfs_del(dev, adj_dev->name, dev_list);
 
 	list_del_rcu(&adj->list);
-	pr_debug("dev_put for %s, because link removed from %s to %s\n",
+	pr_debug("adjacency: dev_put for %s, because link removed from %s to %s\n",
 		 adj_dev->name, dev->name, adj_dev->name);
 	dev_put(adj_dev);
 	kfree_rcu(adj, rcu);
-- 
2.1.4

