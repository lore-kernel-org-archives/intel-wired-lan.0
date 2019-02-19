From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:04 -0800
Subject: [Intel-wired-lan] [PATCH S15 04/14] ice: Do not bail out when
 filter already exists
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Preethi Banala <preethi.banala@intel.com>

If filter already exists, do not go through error path flow but instead
continue to process rest of the function. Hence have an appropriate check
after adding MAC filters.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dad17d8c8b61..c1a44a65ec6c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -260,7 +260,11 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 	/* Add mac addresses in the sync list */
 	status = ice_add_mac(hw, &vsi->tmp_sync_list);
 	ice_free_fltr_list(dev, &vsi->tmp_sync_list);
-	if (status) {
+	/* If filter is added successfully or already exists, do not go into
+	 * 'if' condition and report it as error. Instead continue processing
+	 * rest of the function.
+	 */
+	if (status && status != ICE_ERR_ALREADY_EXISTS) {
 		netdev_err(netdev, "Failed to add MAC filters\n");
 		/* If there is no more space for new umac filters, vsi
 		 * should go into promiscuous mode. There should be some
-- 
2.14.5

