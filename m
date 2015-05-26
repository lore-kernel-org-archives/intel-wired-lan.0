From: John Fastabend <john.fastabend@gmail.com>
Date: Tue, 26 May 2015 08:22:49 -0700
Subject: [Intel-wired-lan] [net-next PATCH v5 1/2] ethtool: Add helper
 routines to pass vf to rx_flow_spec
Message-ID: <20150526152231.29428.81833.stgit@nitbit.x32>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ring_cookie is 64 bits wide which is much larger than can be used
for actual queue index values. So provide some helper routines to
pack a VF index into the cookie. This is useful to steer packets to
a VF ring without having to know the queue layout of the device.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 include/uapi/linux/ethtool.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 2e49fc8..e367dfe 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -796,6 +796,31 @@ struct ethtool_rx_flow_spec {
 	__u32		location;
 };
 
+/* How rings are layed out when accessing virtual functions or
+ * offloaded queues is device specific. To allow users to do flow
+ * steering and specify these queues the ring cookie is partitioned
+ * into a 32bit queue index with an 8 bit virtual function id.
+ * This also leaves the 3bytes for further specifiers. It is possible
+ * future devices may support more than 256 virtual functions if
+ * devices start supporting PCIe w/ARI. However at the moment I
+ * do not know of any devices that support this so I do not reserve
+ * space for this at this time. If a future patch consumes the next
+ * byte it should be aware of this possiblity.
+ */
+#define ETHTOOL_RX_FLOW_SPEC_RING	0x00000000FFFFFFFFLL
+#define ETHTOOL_RX_FLOW_SPEC_RING_VF	0x000000FF00000000LL
+#define ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF 32
+static inline __u64 ethtool_get_flow_spec_ring(__u64 ring_cookie)
+{
+	return ETHTOOL_RX_FLOW_SPEC_RING & ring_cookie;
+};
+
+static inline __u64 ethtool_get_flow_spec_ring_vf(__u64 ring_cookie)
+{
+	return (ETHTOOL_RX_FLOW_SPEC_RING_VF & ring_cookie) >>
+				ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
+};
+
 /**
  * struct ethtool_rxnfc - command to get or set RX flow classification rules
  * @cmd: Specific command number - %ETHTOOL_GRXFH, %ETHTOOL_SRXFH,

