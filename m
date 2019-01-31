From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 31 Jan 2019 13:57:16 -0800
Subject: [Intel-wired-lan] [STABLE 1/4] ice: Update expected FW version
In-Reply-To: <20190131215719.8272-1-anirudh.venkataramanan@intel.com>
References: <20190131215719.8272-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190131215719.8272-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a backport of mainline commit ac5a8aef112e ("ice: Update
expected FW version"). This change is required so that the driver
can work with the latest firmware. Without this change, the driver
fails probe.

Update to the current firmware major and minor version which are
1 and 3 respectively.

Also remove an empty comment line.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index ea02b89243e2..f3f8327833aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -18,11 +18,10 @@
 
 /* Defines that help manage the driver vs FW API checks.
  * Take a look at ice_aq_ver_check in ice_controlq.c for actual usage.
- *
  */
 #define EXP_FW_API_VER_BRANCH		0x00
-#define EXP_FW_API_VER_MAJOR		0x00
-#define EXP_FW_API_VER_MINOR		0x01
+#define EXP_FW_API_VER_MAJOR		0x01
+#define EXP_FW_API_VER_MINOR		0x03
 
 /* Different control queue types: These are mainly for SW consumption. */
 enum ice_ctl_q {
-- 
2.17.2

