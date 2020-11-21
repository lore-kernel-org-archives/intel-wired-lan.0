From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 20 Nov 2020 16:38:33 -0800
Subject: [Intel-wired-lan] [net 4/6] ice: update dev_addr in
 ice_set_mac_address even if HW filter exists
In-Reply-To: <20201121003835.48424-1-anthony.l.nguyen@intel.com>
References: <20201121003835.48424-1-anthony.l.nguyen@intel.com>
Message-ID: <20201121003835.48424-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nick Nunley <nicholas.d.nunley@intel.com>

Fix the driver to copy the MAC address configured in ndo_set_mac_address
into dev_addr, even if the MAC filter already exists in HW. In some
situations (e.g. bonding) the netdev's dev_addr could have been modified
outside of the driver, with no change to the HW filter, so the driver
cannot assume that they match.

Fixes: 757976ab16be ("ice: Fix check for removing/adding mac filters")
Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2dea4d0e9415..7986c677cab5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4887,9 +4887,15 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
 		goto err_update_filters;
 	}
 
-	/* Add filter for new MAC. If filter exists, just return success */
+	/* Add filter for new MAC. If filter exists, return success */
 	status = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
 	if (status == ICE_ERR_ALREADY_EXISTS) {
+		/* Although this MAC filter is already present in hardware it's
+		 * possible in some cases (e.g. bonding) that dev_addr was
+		 * modified outside of the driver and needs to be restored back
+		 * to this value.
+		 */
+		memcpy(netdev->dev_addr, mac, netdev->addr_len);
 		netdev_dbg(netdev, "filter for MAC %pM already exists\n", mac);
 		return 0;
 	}
-- 
2.20.1

