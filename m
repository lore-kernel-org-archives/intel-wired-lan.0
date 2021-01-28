From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 28 Jan 2021 10:17:02 -0800
Subject: [Intel-wired-lan] [net-queue v3] virtchnl: Fix layout of RSS
 structures
Message-ID: <20210128181702.1941534-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Norbert Ciosek <norbertx.ciosek@intel.com>

Remove padding from RSS structures. Previous layout
could lead to unwanted compiler optimizations
in loops when iterating over key and lut arrays.

Fixes: 65ece6de0114 ("virtchnl: Add missing explicit padding to structures")
Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
---
v3: Removed footer
v2: Removed padding instead of moving "key" and "lut" fields
at the end of RSS structures.

 include/linux/avf/virtchnl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 40bad71865ea..532bcbfc4716 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -476,7 +476,6 @@ struct virtchnl_rss_key {
 	u16 vsi_id;
 	u16 key_len;
 	u8 key[1];         /* RSS hash key, packed bytes */
-	u8 pad[1];
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
@@ -485,7 +484,6 @@ struct virtchnl_rss_lut {
 	u16 vsi_id;
 	u16 lut_entries;
 	u8 lut[1];        /* RSS lookup table */
-	u8 pad[1];
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
-- 
2.26.2

