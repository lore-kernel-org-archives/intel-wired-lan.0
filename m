From: David Ahern <dsa@cumulusnetworks.com>
Date: Fri, 14 Oct 2016 18:28:41 -0700
Subject: [Intel-wired-lan] [PATCH net-next 01/11] net: Remove refnr arg when
	inserting link adjacencies
In-Reply-To: <1476494931-31813-1-git-send-email-dsa@cumulusnetworks.com>
References: <1476494931-31813-1-git-send-email-dsa@cumulusnetworks.com>
Message-ID: <1476494931-31813-2-git-send-email-dsa@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 93409033ae65 ("net: Add netdev all_adj_list refcnt propagation to
fix panic") propagated the refnr to insert and remove functions tracking
the netdev adjacency graph. However, for the insert path the refnr can
only be 1. Accordingly, remove the refnr argument to make that clear.
ie., the refnr arg in 93409033ae65 was only needed for the remove path.

Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
---
 net/core/dev.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6498cc2ba8f6..5399af8fdac0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5453,7 +5453,6 @@ static inline bool netdev_adjacent_is_neigh_list(struct net_device *dev,
 
 static int __netdev_adjacent_dev_insert(struct net_device *dev,
 					struct net_device *adj_dev,
-					u16 ref_nr,
 					struct list_head *dev_list,
 					void *private, bool master)
 {
@@ -5463,7 +5462,7 @@ static int __netdev_adjacent_dev_insert(struct net_device *dev,
 	adj = __netdev_find_adj(adj_dev, dev_list);
 
 	if (adj) {
-		adj->ref_nr += ref_nr;
+		adj->ref_nr += 1;
 		return 0;
 	}
 
@@ -5473,7 +5472,7 @@ static int __netdev_adjacent_dev_insert(struct net_device *dev,
 
 	adj->dev = adj_dev;
 	adj->master = master;
-	adj->ref_nr = ref_nr;
+	adj->ref_nr = 1;
 	adj->private = private;
 	dev_hold(adj_dev);
 
@@ -5547,22 +5546,21 @@ static void __netdev_adjacent_dev_remove(struct net_device *dev,
 
 static int __netdev_adjacent_dev_link_lists(struct net_device *dev,
 					    struct net_device *upper_dev,
-					    u16 ref_nr,
 					    struct list_head *up_list,
 					    struct list_head *down_list,
 					    void *private, bool master)
 {
 	int ret;
 
-	ret = __netdev_adjacent_dev_insert(dev, upper_dev, ref_nr, up_list,
+	ret = __netdev_adjacent_dev_insert(dev, upper_dev, up_list,
 					   private, master);
 	if (ret)
 		return ret;
 
-	ret = __netdev_adjacent_dev_insert(upper_dev, dev, ref_nr, down_list,
+	ret = __netdev_adjacent_dev_insert(upper_dev, dev, down_list,
 					   private, false);
 	if (ret) {
-		__netdev_adjacent_dev_remove(dev, upper_dev, ref_nr, up_list);
+		__netdev_adjacent_dev_remove(dev, upper_dev, 1, up_list);
 		return ret;
 	}
 
@@ -5570,10 +5568,9 @@ static int __netdev_adjacent_dev_link_lists(struct net_device *dev,
 }
 
 static int __netdev_adjacent_dev_link(struct net_device *dev,
-				      struct net_device *upper_dev,
-				      u16 ref_nr)
+				      struct net_device *upper_dev)
 {
-	return __netdev_adjacent_dev_link_lists(dev, upper_dev, ref_nr,
+	return __netdev_adjacent_dev_link_lists(dev, upper_dev,
 						&dev->all_adj_list.upper,
 						&upper_dev->all_adj_list.lower,
 						NULL, false);
@@ -5602,12 +5599,12 @@ static int __netdev_adjacent_dev_link_neighbour(struct net_device *dev,
 						struct net_device *upper_dev,
 						void *private, bool master)
 {
-	int ret = __netdev_adjacent_dev_link(dev, upper_dev, 1);
+	int ret = __netdev_adjacent_dev_link(dev, upper_dev);
 
 	if (ret)
 		return ret;
 
-	ret = __netdev_adjacent_dev_link_lists(dev, upper_dev, 1,
+	ret = __netdev_adjacent_dev_link_lists(dev, upper_dev,
 					       &dev->adj_list.upper,
 					       &upper_dev->adj_list.lower,
 					       private, master);
@@ -5676,7 +5673,7 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 		list_for_each_entry(j, &upper_dev->all_adj_list.upper, list) {
 			pr_debug("Interlinking %s with %s, non-neighbour\n",
 				 i->dev->name, j->dev->name);
-			ret = __netdev_adjacent_dev_link(i->dev, j->dev, i->ref_nr);
+			ret = __netdev_adjacent_dev_link(i->dev, j->dev);
 			if (ret)
 				goto rollback_mesh;
 		}
@@ -5686,7 +5683,7 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	list_for_each_entry(i, &upper_dev->all_adj_list.upper, list) {
 		pr_debug("linking %s's upper device %s with %s\n",
 			 upper_dev->name, i->dev->name, dev->name);
-		ret = __netdev_adjacent_dev_link(dev, i->dev, i->ref_nr);
+		ret = __netdev_adjacent_dev_link(dev, i->dev);
 		if (ret)
 			goto rollback_upper_mesh;
 	}
@@ -5695,7 +5692,7 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	list_for_each_entry(i, &dev->all_adj_list.lower, list) {
 		pr_debug("linking %s's lower device %s with %s\n", dev->name,
 			 i->dev->name, upper_dev->name);
-		ret = __netdev_adjacent_dev_link(i->dev, upper_dev, i->ref_nr);
+		ret = __netdev_adjacent_dev_link(i->dev, upper_dev);
 		if (ret)
 			goto rollback_lower_mesh;
 	}
-- 
2.1.4

