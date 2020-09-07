From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  7 Sep 2020 17:02:14 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 1/4] xsk: add XSK_NAPI_WEIGHT
 define
In-Reply-To: <20200907150217.30888-1-bjorn.topel@gmail.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
Message-ID: <20200907150217.30888-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

The NAPI budget (NAPI_POLL_WEIGHT), meaning the number of received
packets that are allowed to be processed for each NAPI invocation,
takes into consideration that each received packet is aimed for the
kernel networking stack.

That is not the case for the AF_XDP receive path, where the cost of
each packet is significantly less. Therefore, this commit adds a new
NAPI budget, which is the NAPI_POLL_WEIGHT scaled by 4. Typically that
would be 256 in most configuration. It is encouraged that AF_XDP
zero-copy capable drivers use the XSK_NAPI_WEIGHT, when zero-copy is
enabled.

Processing 256 packets targeted for AF_XDP is still less work than 64
(NAPI_POLL_WEIGHT) packets going to the kernel networking stack.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/net/xdp_sock_drv.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 5b1ee8a9976d..4fc8e931d56f 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -7,8 +7,11 @@
 #define _LINUX_XDP_SOCK_DRV_H
 
 #include <net/xdp_sock.h>
+#include <linux/netdevice.h>
 #include <net/xsk_buff_pool.h>
 
+#define XSK_NAPI_WEIGHT (NAPI_POLL_WEIGHT << 2)
+
 #ifdef CONFIG_XDP_SOCKETS
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
-- 
2.25.1

