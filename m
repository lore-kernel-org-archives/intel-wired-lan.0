From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:16:30 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 07/10] macvlan: Provide
 function for interfaces to release HW offload
In-Reply-To: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180403211630.7880.85594.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch provides a basic function to allow a lower device to disable
macvlan offload if it was previously enabled on a given macvlan. The idea
here is to allow for recovery from failure should the lowerdev run out of
resources.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/if_macvlan.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
index 0221390..2e55e4c 100644
--- a/include/linux/if_macvlan.h
+++ b/include/linux/if_macvlan.h
@@ -97,4 +97,12 @@ static inline bool macvlan_supports_dest_filter(struct net_device *dev)
 	       macvlan->mode == MACVLAN_MODE_VEPA ||
 	       macvlan->mode == MACVLAN_MODE_BRIDGE;
 }
+
+static inline int macvlan_release_l2fw_offload(struct net_device *dev)
+{
+	struct macvlan_dev *macvlan = netdev_priv(dev);
+
+	macvlan->accel_priv = NULL;
+	return dev_uc_add(macvlan->lowerdev, dev->dev_addr);
+}
 #endif /* _LINUX_IF_MACVLAN_H */

