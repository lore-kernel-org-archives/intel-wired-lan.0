From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:32 -0400
Subject: [Intel-wired-lan] [next PATCH S12 04/15] i40e/i40evf: remove unused
	opcode
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This opcode is not required. VFs that program RSS through the firmware
do it by interacting directly with the firmware, and do not need to use
the virtual channel for this functionality.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Iaf17d2600e28ff1b6be8653f2fe9df1facd23b0e
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 1 -
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
index 0f8d415..95d0f8c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
@@ -81,7 +81,6 @@ enum i40e_virtchnl_ops {
 	I40E_VIRTCHNL_OP_GET_STATS = 15,
 	I40E_VIRTCHNL_OP_FCOE = 16,
 	I40E_VIRTCHNL_OP_EVENT = 17,
-	I40E_VIRTCHNL_OP_CONFIG_RSS = 18,
 };
 
 /* Virtual channel message descriptor. This overlays the admin queue
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index e6db20e..cadda64 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -81,7 +81,6 @@ enum i40e_virtchnl_ops {
 	I40E_VIRTCHNL_OP_GET_STATS = 15,
 	I40E_VIRTCHNL_OP_FCOE = 16,
 	I40E_VIRTCHNL_OP_EVENT = 17,
-	I40E_VIRTCHNL_OP_CONFIG_RSS = 18,
 };
 
 /* Virtual channel message descriptor. This overlays the admin queue
-- 
1.9.3

