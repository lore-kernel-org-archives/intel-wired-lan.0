From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:22 -0700
Subject: [Intel-wired-lan] [PATCH S44 10/14] ice: Poll for reset completion
 when DDP load fails
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

There are certain cases where the DDP load fails and the FW issues a
core reset. For these cases, wait for reset to complete before
proceeding with reset of the driver init.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fcd5c53202d9..1853dca3f364 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3111,6 +3111,9 @@ ice_log_pkg_init(struct ice_hw *hw, enum ice_status *status)
 		case ICE_AQ_RC_EBADMAN:
 		case ICE_AQ_RC_EBADBUF:
 			dev_err(dev, "An error occurred on the device while loading the DDP package.  The device will be reset.\n");
+			/* poll for reset to complete */
+			if (ice_check_reset(hw))
+				dev_err(dev, "Error resetting device. Please reload the driver\n");
 			return;
 		default:
 			break;
-- 
2.20.1

