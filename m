From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 30 Mar 2022 14:01:44 +0300
Subject: [Intel-wired-lan] [PATCH net] ixgbe: ensure IPsec VF<->PF
 compatibility
Message-ID: <3702fad8a016170947da5f3c521a9251cf0f4a22.1648637865.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

The VF driver can forward any IPsec flags and such makes the function
is not extendable and prone to backward/forward incompatibility.

If new software runs on VF, it won't know that PF configured something
completely different as it "knows" only XFRM_OFFLOAD_INBOUND flag.

Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
There is no simple fix for this VF/PF incompatibility as long as FW
doesn't filter/decline unsupported options when convey mailbox from VF
to PF.
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index e596e1a9fc75..236f244e3f65 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -903,7 +903,9 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	/* Tx IPsec offload doesn't seem to work on this
 	 * device, so block these requests for now.
 	 */
-	if (!(sam->flags & XFRM_OFFLOAD_INBOUND)) {
+	sam->flags = sam->flags & ~XFRM_OFFLOAD_IPV6;
+	if (!(sam->flags & XFRM_OFFLOAD_INBOUND) ||
+	    sam->flags & ~XFRM_OFFLOAD_INBOUND) {
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
-- 
2.35.1

