From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:13 -0400
Subject: [Intel-wired-lan] [next PATCH S19 12/15] i40e: return the number of
	enabled queues for ETHTOOL_GRXRINGS
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-13-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Helin Zhang <helin.zhang@intel.com>

This patch fixes a problem where using ethtool rxnfc command could
let RX flow hash be set on disabled queues. This patch fixes the
problem by returning the number of enabled queues before setting
rxnfc.

Signed-off-by: Helin Zhang <helin.zhang@intel.com>
Change-ID: Idbac86b0b47ddacc8deee7cd257e41de01cbe5c0

---
Testing-hints: 5535691
Verify that ethtool set rxnfc cannot set the flow hash on queues that
are not active, on a system that has a non power of two number of cpus.
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1a39d4d..9c243aa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2105,7 +2105,7 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
-		cmd->data = vsi->alloc_queue_pairs;
+		cmd->data = vsi->num_queue_pairs;
 		ret = 0;
 		break;
 	case ETHTOOL_GRXFH:
-- 
1.9.3

