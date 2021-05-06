From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:39:57 -0700
Subject: [Intel-wired-lan] [PATCH S59 02/13] ice: add extack when unable to
 read device caps
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When filling out information for the DEVLINK_CMD_INFO_GET, the driver
needs to read some device capabilities. Add an extack message to
properly inform the caller of the failure, as we do for other failures
in this function.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index ecefab6368f8..63a8718586b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -283,6 +283,9 @@ static int ice_devlink_info_get(struct devlink *devlink,
 	/* discover capabilities first */
 	status = ice_discover_dev_caps(hw, &ctx->dev_caps);
 	if (status) {
+		dev_dbg(dev, "Failed to discover device capabilities, status %s aq_err %s\n",
+			ice_stat_str(status), ice_aq_str(hw->adminq.sq_last_status));
+		NL_SET_ERR_MSG_MOD(extack, "Unable to discover device capabilities");
 		err = -EIO;
 		goto out_free_ctx;
 	}
-- 
2.20.1

