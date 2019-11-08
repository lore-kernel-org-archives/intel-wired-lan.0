From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:31 -0800
Subject: [Intel-wired-lan] [PATCH S33 15/15] ice: Update FW API minor version
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kevin Scott <kevin.c.scott@intel.com>

Update FW API minor version to align to current value advertised
by FW in new NVM images.

Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 4df9da359135..bf0ebe6149e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -22,7 +22,7 @@
  */
 #define EXP_FW_API_VER_BRANCH		0x00
 #define EXP_FW_API_VER_MAJOR		0x01
-#define EXP_FW_API_VER_MINOR		0x03
+#define EXP_FW_API_VER_MINOR		0x05
 
 /* Different control queue types: These are mainly for SW consumption. */
 enum ice_ctl_q {
-- 
2.20.1

