From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 22 Aug 2018 16:47:15 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 2/2] ixgbe: fix the return
 value for unsupported VF offload
In-Reply-To: <1534981635-27417-1-git-send-email-shannon.nelson@oracle.com>
References: <1534981635-27417-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1534981635-27417-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When failing the request because we can't support that offload,
reporting EOPNOTSUPP makes much more sense than ENXIO.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 24076b4..7890f4a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -898,7 +898,7 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 	 * device, so block these requests for now.
 	 */
 	if (!(sam->flags & XFRM_OFFLOAD_INBOUND)) {
-		err = -ENXIO;
+		err = -EOPNOTSUPP;
 		goto err_out;
 	}
 
-- 
2.7.4

