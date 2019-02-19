From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 19 Feb 2019 15:04:06 -0800
Subject: [Intel-wired-lan] [PATCH S15 06/14] ice: Add missing case in
 print_link_msg for printing flow control
In-Reply-To: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190219230414.25627-7-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we aren't checking for the ICE_FC_NONE case for the current
flow control mode. This is causing "Unknown" to be printed for the
current flow control method if flow control is disabled. Fix this by
adding the case for ICE_FC_NONE to print "None".

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c1a44a65ec6c..e53166cd1797 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -595,6 +595,9 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	case ICE_FC_RX_PAUSE:
 		fc = "RX";
 		break;
+	case ICE_FC_NONE:
+		fc = "None";
+		break;
 	default:
 		fc = "Unknown";
 		break;
-- 
2.14.5

