From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:42 -0400
Subject: [Intel-wired-lan] [next PATCH S14 02/15] i40e: Make it clear a
	parameter is never used
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

Flag the filter_mask parameter as __always_unused in the
ndo_bridge_getlink function.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Ifc1e99c7fb84bcbf81cf7b0ac891ad8ca956ffb2
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1c23f4b..7dfe0db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8336,7 +8336,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
  **/
 static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev,
-				   u32 filter_mask, int nlflags)
+				   u32 __always_unused filter_mask,
+				   int nlflags)
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
-- 
1.9.3

