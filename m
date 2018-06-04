From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  4 Jun 2018 14:05:56 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 06/11] net: added netdevice
 operation for Tx
In-Reply-To: <20180604120601.18123-1-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
Message-ID: <20180604120601.18123-7-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Magnus Karlsson <magnus.karlsson@intel.com>

Added ndo_xsk_async_xmit. This ndo "kicks" the netdev to start to pull
userland AF_XDP Tx frames from a NAPI context.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 include/linux/netdevice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 85d91cc41cdf..7ddf9c7ad6d7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1391,6 +1391,8 @@ struct net_device_ops {
 						struct xdp_frame **xdp,
 						u32 flags);
 	void			(*ndo_xdp_flush)(struct net_device *dev);
+	int			(*ndo_xsk_async_xmit)(struct net_device *dev,
+						      u32 queue_id);
 };
 
 /**
-- 
2.14.1

