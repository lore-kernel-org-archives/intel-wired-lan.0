From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 15 May 2018 21:06:07 +0200
Subject: [Intel-wired-lan] [RFC PATCH bpf-next 04/12] net: xdp: added
 bpf_netdev_command XDP_SETUP_XSK_UMEM
In-Reply-To: <20180515190615.23099-1-bjorn.topel@gmail.com>
References: <20180515190615.23099-1-bjorn.topel@gmail.com>
Message-ID: <20180515190615.23099-5-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Extend ndo_bpf with a new command used for register an UMEM to a
queue_id of a netdev.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 include/linux/netdevice.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03ed492c4e14..2084536ad4af 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -817,10 +817,12 @@ enum bpf_netdev_command {
 	BPF_OFFLOAD_DESTROY,
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
+	XDP_SETUP_XSK_UMEM,
 };
 
 struct bpf_prog_offload_ops;
 struct netlink_ext_ack;
+struct xdp_umem;
 
 struct netdev_bpf {
 	enum bpf_netdev_command command;
@@ -851,6 +853,11 @@ struct netdev_bpf {
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

