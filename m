From: Brett Creeley <brett.creeley@intel.com>
Date: Fri,  7 May 2021 15:09:10 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] virtchnl: Remove unused
 VIRTCHNL_VF_OFFLOAD_RSVD define
Message-ID: <20210507220911.116361-1-brett.creeley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove unused define that is currently marked as reserved. This will
open up space for a new feature if/when it's introduced. Also, there is
no reason to keep unused defines around.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/avf/virtchnl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 565deea6ffe8..591e04fa41cc 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -240,7 +240,6 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
  */
 #define VIRTCHNL_VF_OFFLOAD_L2			0x00000001
 #define VIRTCHNL_VF_OFFLOAD_IWARP		0x00000002
-#define VIRTCHNL_VF_OFFLOAD_RSVD		0x00000004
 #define VIRTCHNL_VF_OFFLOAD_RSS_AQ		0x00000008
 #define VIRTCHNL_VF_OFFLOAD_RSS_REG		0x00000010
 #define VIRTCHNL_VF_OFFLOAD_WB_ON_ITR		0x00000020
-- 
2.26.3

