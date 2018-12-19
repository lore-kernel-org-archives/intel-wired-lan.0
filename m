From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Dec 2018 10:03:20 -0800
Subject: [Intel-wired-lan] [PATCH S10 01/15] ice: Fix unused variable build
 warning
In-Reply-To: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181219180334.1104-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Commit 2fd527b72bb6 ("net: ndo_bridge_setlink: Add extack") added a new
parameter "extack" to ice_bridge_setlink but this parameter isn't used
by the function. This results in a warning: unused parameter ?extack?
[-Wunused-parameter]. Fix that by adding an "__always_unused" qualifier.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8725569d11f0..90773b477d19 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3641,7 +3641,8 @@ static int ice_vsi_update_bridge_mode(struct ice_vsi *vsi, u16 bmode)
  */
 static int
 ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
-		   u16 __always_unused flags, struct netlink_ext_ack *extack)
+		   u16 __always_unused flags,
+		   struct netlink_ext_ack __always_unused *extack)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_pf *pf = np->vsi->back;
-- 
2.14.5

