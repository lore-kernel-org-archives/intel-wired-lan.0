From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri,  4 Sep 2020 15:53:28 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 3/6] xsk: introduce
 xsk_do_redirect_rx_full() helper
In-Reply-To: <20200904135332.60259-1-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
Message-ID: <20200904135332.60259-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The xsk_do_redirect_rx_full() helper can be used to check if a failure
of xdp_do_redirect() was due to the AF_XDP socket had a full Rx ring.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/net/xdp_sock_drv.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 5b1ee8a9976d..34c58b5fbc28 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -116,6 +116,11 @@ static inline void xsk_buff_raw_dma_sync_for_device(struct xsk_buff_pool *pool,
 	xp_dma_sync_for_device(pool, dma, size);
 }
 
+static inline bool xsk_do_redirect_rx_full(int err, enum bpf_map_type map_type)
+{
+	return err == -ENOBUFS && map_type == BPF_MAP_TYPE_XSKMAP;
+}
+
 #else
 
 static inline void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
@@ -235,6 +240,10 @@ static inline void xsk_buff_raw_dma_sync_for_device(struct xsk_buff_pool *pool,
 {
 }
 
+static inline bool xsk_do_redirect_rx_full(int err, enum bpf_map_type map_type)
+{
+	return false;
+}
 #endif /* CONFIG_XDP_SOCKETS */
 
 #endif /* _LINUX_XDP_SOCK_DRV_H */
-- 
2.25.1

