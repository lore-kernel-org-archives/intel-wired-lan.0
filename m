From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Wed, 09 Mar 2016 18:32:16 -0500
Subject: [Intel-wired-lan] [PATCH] [net-next] net: ixgbe: Extend cls_u32
 offload to support UDP headers.
Message-ID: <20160309233215.32377.54007.stgit@sdncamp.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Added support to match on UDP fields in the transport layer.
Extended core logic to support multiple headers.

Verified with the following filters :

# tc qdisc add dev enp2s0f0 ingress
# tc filter add dev enp2s0f0 parent ffff: protocol ip prio 99 \
	handle 1: u32 divisor 1
# tc filter add dev enp2s0f0 protocol ip parent ffff: prio 99 \
	u32 ht 800: order 1 link 1: \
	offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 6 ff
# tc filter add dev enp2s0f0 parent ffff: protocol ip \
	u32 ht 1: order 2 \
	match tcp src 1024 ffff match tcp dst 23 ffff action drop
# tc filter add dev enp2s0f0 parent ffff: protocol ip prio 99 \
	handle 2: u32 divisor 1
# tc filter add dev enp2s0f0 protocol ip parent ffff: prio 99 \
	u32 ht 800: order 3 link 2: \
	offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 17 ff
# tc filter add dev enp2s0f0 parent ffff: protocol ip \
	u32 ht 2: order 4 \
	match udp src 1025 ffff match udp dst 24 ffff action drop

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   19 ++++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_model.h |    8 ++++++++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7a60142..25b81a4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8295,19 +8295,20 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 			return -EINVAL;
 
 		for (i = 0; nexthdr[i].jump; i++) {
-			if (nexthdr->o != cls->knode.sel->offoff ||
-			    nexthdr->s != cls->knode.sel->offshift ||
-			    nexthdr->m != cls->knode.sel->offmask ||
+			if (nexthdr[i].o != cls->knode.sel->offoff ||
+			    nexthdr[i].s != cls->knode.sel->offshift ||
+			    nexthdr[i].m != cls->knode.sel->offmask ||
 			    /* do not support multiple key jumps its just mad */
 			    cls->knode.sel->nkeys > 1)
 				return -EINVAL;
 
-			if (nexthdr->off != cls->knode.sel->keys[0].off ||
-			    nexthdr->val != cls->knode.sel->keys[0].val ||
-			    nexthdr->mask != cls->knode.sel->keys[0].mask)
-				return -EINVAL;
-
-			adapter->jump_tables[link_uhtid] = nexthdr->jump;
+			if (nexthdr[i].off == cls->knode.sel->keys[0].off &&
+			    nexthdr[i].val == cls->knode.sel->keys[0].val &&
+			    nexthdr[i].mask == cls->knode.sel->keys[0].mask) {
+				adapter->jump_tables[link_uhtid] =
+								nexthdr[i].jump;
+				break;
+			}
 		}
 		return 0;
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
index 74c53ad..60adde5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_model.h
@@ -82,6 +82,12 @@ static struct ixgbe_mat_field ixgbe_tcp_fields[] = {
 	{ .val = NULL } /* terminal node */
 };
 
+static struct ixgbe_mat_field ixgbe_udp_fields[] = {
+	{.off = 0, .val = ixgbe_mat_prgm_ports,
+	 .type = IXGBE_ATR_FLOW_TYPE_UDPV4},
+	{ .val = NULL } /* terminal node */
+};
+
 struct ixgbe_nexthdr {
 	/* offset, shift, and mask of position to next header */
 	unsigned int o;
@@ -98,6 +104,8 @@ struct ixgbe_nexthdr {
 static struct ixgbe_nexthdr ixgbe_ipv4_jumps[] = {
 	{ .o = 0, .s = 6, .m = 0xf,
 	  .off = 8, .val = 0x600, .mask = 0xff00, .jump = ixgbe_tcp_fields},
+	{ .o = 0, .s = 6, .m = 0xf,
+	  .off = 8, .val = 0x1100, .mask = 0xff00, .jump = ixgbe_udp_fields},
 	{ .jump = NULL } /* terminal node */
 };
 #endif /* _IXGBE_MODEL_H_ */

