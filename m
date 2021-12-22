From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 22 Dec 2021 07:22:00 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ice: change mode only if
 eswitch is supported
In-Reply-To: <20211222062201.36302-1-michal.swiatkowski@linux.intel.com>
References: <20211222062201.36302-1-michal.swiatkowski@linux.intel.com>
Message-ID: <20211222062201.36302-3-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Support for eswitch can be turned off when reservation for msix fails.
Cover this situation and return error in changing eswitch mode function.

Add new lines in each dev_info call.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index fbe640d501c6..2b6c7d27ac96 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -518,25 +518,34 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		     struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
+	struct device *dev = ice_pf_to_dev(pf);
 
 	if (pf->eswitch_mode == mode)
 		return 0;
 
 	if (pf->num_alloc_vfs) {
-		dev_info(ice_pf_to_dev(pf), "Changing eswitch mode is allowed only if there is no VFs created");
-		NL_SET_ERR_MSG_MOD(extack, "Changing eswitch mode is allowed only if there is no VFs created");
+		dev_info(dev, "Changing eswitch mode is allowed only if there is no VFs created\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Changing eswitch mode is allowed only if there is no VFs created");
+		return -EOPNOTSUPP;
+	}
+
+	if (!ice_is_eswitch_supported(pf)) {
+		dev_info(dev, "There is no eswitch support or eswitch resource allocation failed\n");
+		NL_SET_ERR_MSG_MOD(extack,
+				   "There is no eswitch support or eswitch resource allocation failed");
 		return -EOPNOTSUPP;
 	}
 
 	switch (mode) {
 	case DEVLINK_ESWITCH_MODE_LEGACY:
-		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to legacy",
+		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to legacy\n",
 			 pf->hw.pf_id);
 		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
 		break;
 	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
 	{
-		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
+		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev\n",
 			 pf->hw.pf_id);
 		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
 		break;
-- 
2.31.1

