From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 1 Mar 2021 19:46:54 +0100
Subject: [Intel-wired-lan] Driver i40e have XDP-redirect bug
In-Reply-To: <20210301131832.0d765179@carbon>
References: <20210301131832.0d765179@carbon>
Message-ID: <20210301194654.10513eb2@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 1 Mar 2021 13:18:32 +0100
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> Hi i40e-people + XDP-feature-people, 
> 
> The driver i40e have a XDP-redirect bug, where is it partly broken. It can
> transmit a redirected xdp_frame (from another driver). But broken when
> redirecting a xdp_frame that is received by the driver itself.
> 
> This reminds me about lacking XDP-features, as this "state" is actually
> "supported" (for Intel drivers), when running in 'legacy-rx' mode.  This can
> be configured (via: 'ethtool --set-priv-flags i40e2 legacy-rx on').  When
> running in 'legacy-rx' mode the headroom is zero, which means that xdp_frame
> cannot be created as it is stored in this headroom, but an XDP-prog can
> still run a (DDoS) filter.  (Hint grepping after xdp_redirect stats is not enough).
> 
> The BUG I experience *is* that headroom is zero, but 'legacy-rx' mode is off:
> 
>   $ ethtool --show-priv-flags i40e2 | grep legacy-rx
>   legacy-rx             : off
> 
> This is clearly a driver initialization bug as the headroom should not
> be zero in this configuration. Further indication that this is related
> to init order: If while xdp_redirect is running, I change RX-ring size
> (e.g. 'ethtool -G i40e2 rx 1024') then redirect starts working again.
> 
> 
> I will continue to find the offending commit... (to-be-continued)
> (p.s. testing on net-next on top of commit d310ec03a34e92).

The problem is in this commit f7bb0d71d658 ("i40e: store the result of
i40e_rx_offset() onto i40e_ring"), and below patch fix the issue for me.

I am in dialog with Maciej and he will send a proper fix.

The commit is fairly new, but have reached Linus'es tree:
 $ git describe f7bb0d71d658 --contains
 v5.12-rc1~200^2~54^2~2
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

[PATCH] i40e: fix packet headroom

From: Jesper Dangaard Brouer <brouer@redhat.com>

Fixes: f7bb0d71d658 ("i40e: store the result of i40e_rx_offset() onto i40e_ring")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   14 ++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   12 ------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8bb8eb65add9..4c0b4bc38338 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3259,6 +3259,17 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 	return 0;
 }
 
+/**
+ * i40e_rx_offset - Return expected offset into page to access data
+ * @rx_ring: Ring we are requesting offset of
+ *
+ * Returns the offset value for ring into the data buffer.
+ */
+static unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
+{
+	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
+}
+
 /**
  * i40e_configure_rx_ring - Configure a receive ring context
  * @ring: The Rx ring to configure
@@ -3370,6 +3381,9 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	else
 		set_ring_build_skb_enabled(ring);
 
+	ring->rx_offset = i40e_rx_offset(ring);
+	pr_info("XXX %s() ring->rx_offset = %d\n", __func__, ring->rx_offset);
+
 	/* cache tail for quicker writes, and clear the reg before use */
 	ring->tail = hw->hw_addr + I40E_QRX_TAIL(pf_q);
 	writel(0, ring->tail);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f6f1af94cca0..e398b8ac2a85 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1569,17 +1569,6 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 	}
 }
 
-/**
- * i40e_rx_offset - Return expected offset into page to access data
- * @rx_ring: Ring we are requesting offset of
- *
- * Returns the offset value for ring into the data buffer.
- */
-static unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
-{
-	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
-}
-
 /**
  * i40e_setup_rx_descriptors - Allocate Rx descriptors
  * @rx_ring: Rx descriptor ring (for a specific queue) to setup
@@ -1608,7 +1597,6 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
-	rx_ring->rx_offset = i40e_rx_offset(rx_ring);
 
 	/* XDP RX-queue info only needed for RX rings exposed to XDP */
 	if (rx_ring->vsi->type == I40E_VSI_MAIN) {

