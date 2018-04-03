From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:25 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 06/10] macvlan: Add
 function to test for destination filtering support
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211624.7880.72399.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds a function indicating if a given macvlan can fully supports
destination filtering, especially as it relates to unicast traffic. For
those macvlan interfaces that do not support destination filtering such
passthru or source mode filtering we should not be enabling offload
support.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/if_macvlan.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
index 80089d6..0221390 100644
--- a/include/linux/if_macvlan.h
+++ b/include/linux/if_macvlan.h
@@ -88,4 +88,13 @@ static inline void *macvlan_accel_priv(struct net_device *dev)
 
 	return macvlan->accel_priv;
 }
+
+static inline bool macvlan_supports_dest_filter(struct net_device *dev)
+{
+	struct macvlan_dev *macvlan = netdev_priv(dev);
+
+	return macvlan->mode == MACVLAN_MODE_PRIVATE ||
+	       macvlan->mode == MACVLAN_MODE_VEPA ||
+	       macvlan->mode == MACVLAN_MODE_BRIDGE;
+}
 #endif /* _LINUX_IF_MACVLAN_H */

