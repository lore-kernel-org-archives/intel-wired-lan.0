From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:30:46 -0700
Subject: [Intel-wired-lan] [PATCH S20 09/15] ice: Change message level
In-Reply-To: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173052.28928-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Change the message level of the MTU change log message from debug to
info.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 59971f6224f1..95ac79bfd92a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3892,7 +3892,7 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 		}
 	}
 
-	netdev_dbg(netdev, "changed mtu to %d\n", new_mtu);
+	netdev_info(netdev, "changed MTU to %d\n", new_mtu);
 	return 0;
 }
 
-- 
2.20.1

