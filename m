From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 18 Oct 2018 08:37:05 -0700
Subject: [Intel-wired-lan] [PATCH 3/7] ice: Update expected FW version
In-Reply-To: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181018153709.32664-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update to the current firmware major and minor version which are
1 and 3 respectively.

Also remove an empty comment line.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 437f832fd7c4..0038a4109c99 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -19,11 +19,10 @@
 
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
2.14.3

