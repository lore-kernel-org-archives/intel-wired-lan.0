From: alardam@gmail.com <alardam@gmail.com>
Date: Mon, 16 Nov 2020 10:34:45 +0100
Subject: [Intel-wired-lan] [PATCH 1/8] net: ethtool: extend netdev_features
 flag set
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
Message-ID: <20201116093452.7541-2-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Implement support for checking if a netdev has XDP and AF_XDP zero copy
support. Previously, there was no way to do this other than to try
to create an AF_XDP socket on the interface or load an XDP program
and see if it worked. This commit changes this by extending existing
netdev_features in the following way:
 * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRECT})
 * af-xdp-zc  - AF_XDP zero copy support

By default these new flags are disabled for all drivers.

    $ ethtool -k enp1s0f0
     Features for enp1s0f0:
     ..
     xdp: off [fixed]
     af-xdp-zc: off [fixed]

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 include/linux/netdev_features.h |  6 ++++++
 include/net/xdp.h               | 13 +++++++++++++
 include/net/xdp_sock_drv.h      | 11 +++++++++++
 net/ethtool/common.c            |  2 ++
 4 files changed, 32 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 934de56644e7..d154ee7209b9 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -85,6 +85,8 @@ enum {
 
 	NETIF_F_HW_MACSEC_BIT,		/* Offload MACsec operations */
 
+	NETIF_F_XDP_BIT,		/* XDP support */
+	NETIF_F_AF_XDP_ZC_BIT,		/* AF_XDP zero-copy support */
 	/*
 	 * Add your fresh new feature above and remember to update
 	 * netdev_features_strings[] in net/core/ethtool.c and maybe
@@ -157,6 +159,9 @@ enum {
 #define NETIF_F_GRO_FRAGLIST	__NETIF_F(GRO_FRAGLIST)
 #define NETIF_F_GSO_FRAGLIST	__NETIF_F(GSO_FRAGLIST)
 #define NETIF_F_HW_MACSEC	__NETIF_F(HW_MACSEC)
+#define NETIF_F_XDP		__NETIF_F(XDP)
+#define NETIF_F_AF_XDP_ZC	__NETIF_F(AF_XDP_ZC)
+
 
 /* Finds the next feature with the highest number of the range of start till 0.
  */
@@ -182,6 +187,7 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 /* Features valid for ethtool to change */
 /* = all defined minus driver/device-class-related */
 #define NETIF_F_NEVER_CHANGE	(NETIF_F_VLAN_CHALLENGED | \
+				 NETIF_F_XDP | NETIF_F_AF_XDP_ZC | \
 				 NETIF_F_LLTX | NETIF_F_NETNS_LOCAL)
 
 /* remember that ((t)1 << t_BITS) is undefined in C99 */
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 7d48b2ae217a..82bb47372b02 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -254,6 +254,19 @@ struct xdp_attachment_info {
 	u32 flags;
 };
 
+#if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
+static __always_inline void
+xdp_set_feature_flag(netdev_features_t *features)
+{
+	*features |= NETIF_F_XDP;
+}
+#else
+static __always_inline void
+xdp_set_feature_flag(netdev_features_t *features)
+{
+}
+#endif
+
 struct netdev_bpf;
 bool xdp_attachment_flags_ok(struct xdp_attachment_info *info,
 			     struct netdev_bpf *bpf);
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 5b1ee8a9976d..86b41f89d09d 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -22,6 +22,12 @@ void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_clear_tx_need_wakeup(struct xsk_buff_pool *pool);
 bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool);
 
+static __always_inline void
+xsk_set_feature_flag(netdev_features_t *features)
+{
+	*features |= NETIF_F_AF_XDP_ZC;
+}
+
 static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 {
 	return XDP_PACKET_HEADROOM + pool->headroom;
@@ -235,6 +241,11 @@ static inline void xsk_buff_raw_dma_sync_for_device(struct xsk_buff_pool *pool,
 {
 }
 
+static __always_inline void
+xsk_set_feature_flag(netdev_features_t *features)
+{
+}
+
 #endif /* CONFIG_XDP_SOCKETS */
 
 #endif /* _LINUX_XDP_SOCK_DRV_H */
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 24036e3055a1..eed225283eee 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -68,6 +68,8 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_TLS_RX_BIT] =	 "tls-hw-rx-offload",
 	[NETIF_F_GRO_FRAGLIST_BIT] =	 "rx-gro-list",
 	[NETIF_F_HW_MACSEC_BIT] =	 "macsec-hw-offload",
+	[NETIF_F_XDP_BIT] =              "xdp",
+	[NETIF_F_AF_XDP_ZC_BIT] =        "af-xdp-zc",
 };
 
 const char
-- 
2.20.1

