From: Magnus Karlsson <magnus.karlsson@intel.com>
Date: Tue, 29 Jan 2019 15:03:50 +0100
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix potential RX buffer
 starvation for AF_XDP
Message-ID: <1548770630-16189-1-git-send-email-magnus.karlsson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the RX rings are created they are also populated with buffers so
that packets can be received. Usually these are kernel buffers, but
for AF_XDP in zero-copy mode, these are user-space buffers and in this
case the application might not have sent down any buffers to the
driver at this point. And if no buffers are allocated at ring creation
time, no packets can be received and no interupts will be generated so
the napi poll function that allocates buffers to the rings will never
get executed.

To recitfy this, we kick the NAPI context of any queue with an
attached AF_XDP zero-copy socket in two places in the code. Once after
an XDP program has loaded and once after the umem is registered.  This
take care of both cases: XDP program gets loaded first then AF_XDP
socket is created, and the reverse, AF_XDP socket is created first,
then XDP program is loaded.

Fixes: d0bcacd0a130 ("ixgbe: add AF_XDP zero-copy Rx support")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 12 ++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index daff818..017c930 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10225,6 +10225,7 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct bpf_prog *old_prog;
+	bool need_reset;
 
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		return -EINVAL;
@@ -10247,9 +10248,10 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 		return -ENOMEM;
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
+	need_reset = (!!prog != !!old_prog);
 
 	/* If transitioning XDP modes reconfigure rings */
-	if (!!prog != !!old_prog) {
+	if (need_reset) {
 		int err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
 		if (err) {
@@ -10265,6 +10267,14 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
+	/* Kick start the NAPI context if there is an AF_XDP socket open
+	 * on that queue id. This so that receiving will start.
+	 */
+	if (need_reset && prog)
+		for (i = 0; i < adapter->num_rx_queues; i++)
+			if (adapter->xdp_ring[i]->xsk_umem)
+				(void)ixgbe_xsk_async_xmit(adapter->netdev, i);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 65c3e2c..654ae92 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -144,11 +144,19 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 		ixgbe_txrx_ring_disable(adapter, qid);
 
 	err = ixgbe_add_xsk_umem(adapter, umem, qid);
+	if (err)
+		return err;
 
-	if (if_running)
+	if (if_running) {
 		ixgbe_txrx_ring_enable(adapter, qid);
 
-	return err;
+		/* Kick start the NAPI context so that receiving will start */
+		err = ixgbe_xsk_async_xmit(adapter->netdev, qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
-- 
2.7.4

