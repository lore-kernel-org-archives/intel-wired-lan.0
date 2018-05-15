From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:10 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 07/12] net: added netdevice
 operation for Tx
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-8-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Added ndo_xsk_async_xmit. This ndo "kicks" the netdev to start pull
userland Tx frames from a NAPI context.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2084536ad4af..8f4292dc6670 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1385,6 +1385,12 @@ struct net_device_ops {
 	int			(*ndo_xdp_xmit)(struct net_device *dev,
 						struct xdp_frame *xdp);
 	void			(*ndo_xdp_flush)(struct net_device *dev);
+	/* AF_XDP Tx function. NB! That in the PoC we take ownership
+	 * of the XDP Tx rings, so you wont be able to XDP_REDIRECT
+	 * there...
+	 */
+	int			(*ndo_xsk_async_xmit)(struct net_device *dev,
+						      u32 queue_id);
 };
 
 /**
-- 
2.14.1

