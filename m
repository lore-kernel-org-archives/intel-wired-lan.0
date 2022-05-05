From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:42 +0300
Subject: [Intel-wired-lan] [PATCH ipsec-next 5/8] ixgbe: propagate XFRM
 offload state direction instead of flags
In-Reply-To: <cover.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
Message-ID: <136e50b0e7daad71a2e3516427133ec8296fc4d0.1651743750.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Convert the ixgbe driver to rely on XFRM offload state direction instead
of flags bits that were not checked at all.

Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 9 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ipsec.c     | 6 +++---
 drivers/net/ethernet/intel/ixgbevf/ipsec.h     | 2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 69d11ff7677d..774de63dd93a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -585,7 +585,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 		return -EINVAL;
 	}
 
-	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		struct rx_sa rsa;
 
 		if (xs->calg) {
@@ -757,7 +757,7 @@ static void ixgbe_ipsec_del_sa(struct xfrm_state *xs)
 	u32 zerobuf[4] = {0, 0, 0, 0};
 	u16 sa_idx;
 
-	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		struct rx_sa *rsa;
 		u8 ipi;
 
@@ -903,8 +903,7 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	/* Tx IPsec offload doesn't seem to work on this
 	 * device, so block these requests for now.
 	 */
-	sam->flags = sam->flags & ~XFRM_OFFLOAD_IPV6;
-	if (sam->flags != XFRM_OFFLOAD_INBOUND) {
+	if (sam->dir != XFRM_DEV_OFFLOAD_IN) {
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -915,7 +914,7 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		goto err_out;
 	}
 
-	xs->xso.flags = sam->flags;
+	xs->xso.dir = sam->dir;
 	xs->id.spi = sam->spi;
 	xs->id.proto = sam->proto;
 	xs->props.family = sam->family;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
index d2b64ff8eb4e..809ab51a7842 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
@@ -74,7 +74,7 @@ struct ixgbe_ipsec {
 
 struct sa_mbx_msg {
 	__be32 spi;
-	u8 flags;
+	u8 dir;
 	u8 proto;
 	u16 family;
 	__be32 addr[4];
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index e763cee0695e..9984ebc62d78 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -25,7 +25,7 @@ static int ixgbevf_ipsec_set_pf_sa(struct ixgbevf_adapter *adapter,
 
 	/* send the important bits to the PF */
 	sam = (struct sa_mbx_msg *)(&msgbuf[1]);
-	sam->flags = xs->xso.flags;
+	sam->dir = xs->xso.dir;
 	sam->spi = xs->id.spi;
 	sam->proto = xs->id.proto;
 	sam->family = xs->props.family;
@@ -280,7 +280,7 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs)
 		return -EINVAL;
 	}
 
-	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		struct rx_sa rsa;
 
 		if (xs->calg) {
@@ -394,7 +394,7 @@ static void ixgbevf_ipsec_del_sa(struct xfrm_state *xs)
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
-	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
+	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 
 		if (!ipsec->rx_tbl[sa_idx].used) {
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.h b/drivers/net/ethernet/intel/ixgbevf/ipsec.h
index 3740725041c3..d22990165353 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.h
@@ -57,7 +57,7 @@ struct ixgbevf_ipsec {
 
 struct sa_mbx_msg {
 	__be32 spi;
-	u8 flags;
+	u8 dir;
 	u8 proto;
 	u16 family;
 	__be32 addr[4];
-- 
2.35.1

