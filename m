From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon,  4 Jun 2018 14:05:53 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 03/11] net: xdp: added
 bpf_netdev_command XDP_{QUERY, SETUP}_XSK_UMEM
In-Reply-To: <20180604120601.18123-1-bjorn.topel@gmail.com>
References: <20180604120601.18123-1-bjorn.topel@gmail.com>
Message-ID: <20180604120601.18123-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Extend ndo_bpf with two new commands used for query zero-copy support
and register an UMEM to a queue_id of a netdev.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/linux/netdevice.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f17785a59d7..85d91cc41cdf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -817,10 +817,13 @@ enum bpf_netdev_command {
 	BPF_OFFLOAD_DESTROY,
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
+	XDP_QUERY_XSK_UMEM,
+	XDP_SETUP_XSK_UMEM,
 };
 
 struct bpf_prog_offload_ops;
 struct netlink_ext_ack;
+struct xdp_umem;
 
 struct netdev_bpf {
 	enum bpf_netdev_command command;
@@ -851,6 +854,11 @@ struct netdev_bpf {
 		struct {
 			struct bpf_offloaded_map *offmap;
 		};
+		/* XDP_SETUP_XSK_UMEM */
+		struct {
+			struct xdp_umem *umem;
+			u16 queue_id;
+		} xsk;
 	};
 };
 
-- 
2.14.1

