From: John Fastabend <john.fastabend@gmail.com>
Date: Thu, 14 May 2015 09:36:28 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbe: Allow flow director to
 use entire queue space
Message-ID: <20150514163616.14473.66892.stgit@nitbit.x32>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Flow director is exported to user space using the ethtool ntuple
support. However, currently it only supports steering traffic to a
subset of the queues in use by the hardware. This change allows
flow director to specify queues that have been assigned to virtual
functions by partitioning the ring_cookie into a 8bit vf specifier
followed by 32bit queue index. At the moment we don't have any
ethernet drivers with more than 2^32 queues on a single function
as best I can tell and nor do I expect this to happen anytime
soon. This way the ring_cookie's normal use for specifying a queue
on a specific PCI function continues to work as expected.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   32 ++++++++++++++++------
 include/uapi/linux/ethtool.h                     |   20 ++++++++++++++
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index eafa9ec..1bb8ddc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2595,18 +2595,35 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	struct ixgbe_fdir_filter *input;
 	union ixgbe_atr_input mask;
 	int err;
+	u8 ring, vf, queue;
 
 	if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
 		return -EOPNOTSUPP;
 
-	/*
-	 * Don't allow programming if the action is a queue greater than
-	 * the number of online Rx queues.
+	/* ring_cookie is a masked into a set of queues and ixgbe pools. */
+	ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
+	vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
+
+	/* The input is validated to ensure the pool is valid and the queue
+	 * selection is valid for the specified pool.
 	 */
-	if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&
-	    (fsp->ring_cookie >= adapter->num_rx_queues))
+	if (!vf &&
+	    (ring != RX_CLS_FLOW_DISC) &&
+	    (ring >= adapter->num_rx_queues))
+		return -EINVAL;
+
+	if (vf &&
+	    ((vf > adapter->num_vfs) ||
+	      ring >= adapter->num_rx_queues_per_pool))
 		return -EINVAL;
 
+	if (ring == IXGBE_FDIR_DROP_QUEUE)
+		queue = IXGBE_FDIR_DROP_QUEUE;
+	else if (!vf)
+		queue = adapter->rx_ring[ring]->reg_idx;
+	else
+		queue = ((vf - 1) * adapter->num_rx_queues_per_pool) + ring;
+
 	/* Don't allow indexes to exist outside of available space */
 	if (fsp->location >= ((1024 << adapter->fdir_pballoc) - 2)) {
 		e_err(drv, "Location out of range\n");
@@ -2683,10 +2700,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 
 	/* program filters to filter memory */
 	err = ixgbe_fdir_write_perfect_filter_82599(hw,
-				&input->filter, input->sw_idx,
-				(input->action == IXGBE_FDIR_DROP_QUEUE) ?
-				IXGBE_FDIR_DROP_QUEUE :
-				adapter->rx_ring[input->action]->reg_idx);
+				&input->filter, input->sw_idx, queue);
 	if (err)
 		goto err_out_w_lock;
 
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 2e49fc8..ecc658d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -796,6 +796,26 @@ struct ethtool_rx_flow_spec {
 	__u32		location;
 };
 
+/* How rings are layed out when accessing virtual functions or
+ * offloaded queues is device specific. To allow users to flow
+ * steering and specify these queues though break the ring cookie
+ * into a 32bit queue index with an 8 bit virtual function id.
+ * This also leaves the 3bytes for further specifiers.
+ */
+#define ETHTOOL_RX_FLOW_SPEC_RING	0x00000000FFFFFFFF
+#define ETHTOOL_RX_FLOW_SPEC_RING_VF	0x000000FF00000000
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

