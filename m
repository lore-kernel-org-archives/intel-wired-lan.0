From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:28 -0800
Subject: [Intel-wired-lan] [PATCH S11 01/16] ice: Mark extack argument as
 __always_unused
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Commit 87b0984ebfab ("net: Add extack argument to ndo_fdb_add()") in
net-next added an extended parameter to the .ndo_fdb_add op and changed
ice_fdb_add() accordingly. Update the function header and add the
__always_unused attribute to the new parameter to avoid -Wunused-parameter
warnings.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 48f033928aa2..9d266d754445 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2435,11 +2435,12 @@ static void ice_set_rx_mode(struct net_device *netdev)
  * @addr: the MAC address entry being added
  * @vid: VLAN id
  * @flags: instructions from stack about fdb operation
+ * @extack: netlink extended ack
  */
-static int ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
-		       struct net_device *dev, const unsigned char *addr,
-		       u16 vid, u16 flags,
-		       struct netlink_ext_ack *extack)
+static int
+ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
+	    struct net_device *dev, const unsigned char *addr, u16 vid,
+	    u16 flags, struct netlink_ext_ack __always_unused *extack)
 {
 	int err;
 
-- 
2.14.5

