From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:09 -0700
Subject: [Intel-wired-lan] [PATCH S41 11/15] ice: Fix check for
 removing/adding mac filters
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

In function ice_set_mac_address, we will remove old dev_addr before
adding the new MAC. In the removing and adding process of the MAC,
there is no need to return error if the check finds the to-be-removed
dev_addr does not exist in the MAC filter list or the to-be-added mac
already exists, keep going or return success accordingly.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 99fa36f35a4f..5eca66849e52 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3771,19 +3771,24 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
 		return -EBUSY;
 	}
 
-	/* Clean up old MAC filter before changing the MAC address */
+	/* Clean up old MAC filter. Not an error if old filter doesn't exist */
 	status = ice_fltr_remove_mac(vsi, netdev->dev_addr, ICE_FWD_TO_VSI);
-	if (status) {
+	if (status && status != ICE_ERR_DOES_NOT_EXIST) {
 		err = -EADDRNOTAVAIL;
 		goto err_update_filters;
 	}
 
+	/* Add filter for new MAC. If filter exists, just return success */
 	status = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
-	if (status) {
-		err = -EADDRNOTAVAIL;
-		goto err_update_filters;
+	if (status == ICE_ERR_ALREADY_EXISTS) {
+		netdev_dbg(netdev, "filter for MAC %pM already exists\n", mac);
+		return 0;
 	}
 
+	/* error if the new filter addition failed */
+	if (status)
+		err = -EADDRNOTAVAIL;
+
 err_update_filters:
 	if (err) {
 		netdev_err(netdev, "can't set MAC %pM. filter update failed\n",
-- 
2.20.1

