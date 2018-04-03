From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:19 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 05/10] macvlan:
 macvlan_count_rx shouldn't be static inline AND extern
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211619.7880.24524.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It doesn't make sense to define macvlan_count_rx as a static inline and
then add a forward declaration after that as an extern. I am dropping the
extern declaration since it seems like it is something that likely got
missed when the function was made an inline.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/if_macvlan.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
index c5106ce..80089d6 100644
--- a/include/linux/if_macvlan.h
+++ b/include/linux/if_macvlan.h
@@ -61,10 +61,6 @@ extern int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 				  struct nlattr *tb[], struct nlattr *data[],
 				  struct netlink_ext_ack *extack);
 
-extern void macvlan_count_rx(const struct macvlan_dev *vlan,
-			     unsigned int len, bool success,
-			     bool multicast);
-
 extern void macvlan_dellink(struct net_device *dev, struct list_head *head);
 
 extern int macvlan_link_register(struct rtnl_link_ops *ops);

