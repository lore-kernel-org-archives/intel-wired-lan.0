From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:11 -0400
Subject: [Intel-wired-lan] [net-next S5 04/15] i40e: Remove incorrect
	#ifdef's
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch removes some #ifdef's that should not be there. They
were stopping code that is needed from being compiled in.

With these #ifdef's removed, changes are needed in the driver
to fix some compile errors: adding missing parameters to
the definition of ndo_bridge_setlink and a ndo_dflt_brige_getlink call.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Change-ID: I5516614e1bc50b6bca0647cef971bc96161ba2de
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9ec7f51..1b73979 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7989,7 +7989,6 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	return err;
 }
 
-#ifdef HAVE_BRIDGE_ATTRIBS
 /**
  * i40e_ndo_bridge_setlink - Set the hardware bridge mode
  * @dev: the netdev being configured
@@ -8003,7 +8002,8 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
  * bridge mode enabled.
  **/
 static int i40e_ndo_bridge_setlink(struct net_device *dev,
-				   struct nlmsghdr *nlh)
+				   struct nlmsghdr *nlh,
+				   u16 flags)
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
@@ -8069,14 +8069,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
  * Return the mode in which the hardware bridge is operating in
  * i.e VEB or VEPA.
  **/
-#ifdef HAVE_BRIDGE_FILTER
 static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev,
 				   u32 __always_unused filter_mask)
-#else
-static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-				   struct net_device *dev)
-#endif /* HAVE_BRIDGE_FILTER */
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
@@ -8097,9 +8092,9 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	if (!veb)
 		return 0;
 
-	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode);
+	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode, 0,
+				       0);
 }
-#endif /* HAVE_BRIDGE_ATTRIBS */
 
 #define I40E_MAX_TUNNEL_HDR_LEN 80
 /**
@@ -8154,10 +8149,8 @@ static const struct net_device_ops i40e_netdev_ops = {
 #endif
 	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
 	.ndo_fdb_add		= i40e_ndo_fdb_add,
-#ifdef HAVE_BRIDGE_ATTRIBS
 	.ndo_bridge_getlink	= i40e_ndo_bridge_getlink,
 	.ndo_bridge_setlink	= i40e_ndo_bridge_setlink,
-#endif /* HAVE_BRIDGE_ATTRIBS */
 	.ndo_features_check	= i40e_features_check,
 };
 
-- 
1.9.3

