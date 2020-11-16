From: alardam@gmail.com <alardam@gmail.com>
Date: Mon, 16 Nov 2020 10:34:51 +0100
Subject: [Intel-wired-lan] [PATCH 7/8] libbpf: add API to get XSK/XDP caps
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
Message-ID: <20201116093452.7541-8-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Add public xsk API to read supported XDP functions of a netdev:
 - XDP driver mode (SKB, DRV),
 - XSK bind mode (COPY, ZEROCOPY).

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/xsk.c      | 51 +++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/xsk.h      |  3 ++-
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 29ff4807b909..0867dd078a65 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -345,4 +345,5 @@ LIBBPF_0.3.0 {
 		btf__parse_split;
 		btf__new_empty_split;
 		btf__new_split;
+		xsk_socket__get_caps;
 } LIBBPF_0.2.0;
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 7951f7ea6db3..433c58fbed68 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -15,7 +15,6 @@
 #include <arpa/inet.h>
 #include <asm/barrier.h>
 #include <linux/compiler.h>
-#include <linux/ethtool.h>
 #include <linux/filter.h>
 #include <linux/if_ether.h>
 #include <linux/if_link.h>
@@ -31,6 +30,7 @@
 #include <sys/types.h>
 
 #include "bpf.h"
+#include "ethtool.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
 #include "xsk.h"
@@ -931,3 +931,52 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 		close(xsk->fd);
 	free(xsk);
 }
+
+int xsk_socket__get_caps(const char *ifname, __u32 *xdp_caps, __u16 *bind_caps)
+{
+	struct ethnl_params param;
+	int ret;
+
+	if (!xdp_caps || !bind_caps || !ifname ||
+	    (strnlen(ifname, IFNAMSIZ) >= IFNAMSIZ))
+		return -EINVAL;
+
+	param.nl_family = ETHTOOL_GENL_NAME;
+	param.xdp_zc_flags = 0;
+	param.ifname = ifname;
+	param.xdp_flags = 0;
+
+	/* First, get the netlink family id */
+	ret = libbpf_ethnl_get_ethtool_family_id(&param);
+	if (ret)
+		return ret;
+
+	/* Second, get number of features */
+	param.features = 0;
+	ret = libbpf_ethnl_get_netdev_features(&param);
+	if (ret)
+		return ret;
+
+	/* Third, get the features description */
+	ret = libbpf_ethnl_get_netdev_features(&param);
+	if (ret)
+		return ret;
+
+	*xdp_caps  = XDP_FLAGS_SKB_MODE;
+	*bind_caps = XDP_COPY;
+
+	if (param.xdp_idx == -1 || param.xdp_zc_idx == -1)
+		return 0;
+
+	/* Finally, get features flags and process it */
+	ret = libbpf_ethnl_get_active_bits(&param);
+	if (!ret) {
+		if (param.xdp_flags) {
+			*xdp_caps |= XDP_FLAGS_DRV_MODE;
+			if (param.xdp_zc_flags)
+				*bind_caps |= XDP_ZEROCOPY;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index 1069c46364ff..ae29004570b2 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -247,7 +247,8 @@ xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 /* Returns 0 for success and -EBUSY if the umem is still in use. */
 LIBBPF_API int xsk_umem__delete(struct xsk_umem *umem);
 LIBBPF_API void xsk_socket__delete(struct xsk_socket *xsk);
-
+LIBBPF_API int xsk_socket__get_caps(const char *ifname, __u32 *xdp_caps,
+				    __u16 *bind_caps);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.20.1

