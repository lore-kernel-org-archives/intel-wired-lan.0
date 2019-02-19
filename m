From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 19 Feb 2019 09:17:04 -0800
Subject: [Intel-wired-lan] [next-queue] fm10k: add missing field
 initializers to TLV attributes)
Message-ID: <20190219171704.2852-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "nosbuild (Code Review)" <nosbuild@intel.com>

Add the missing field initializers for a couple of the TLV attribute
macros. This resolves the last few -Wmissing-field-initializers warnings
for the fm10k Linux driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
index 160bc5b78f99..ceb9b791f799 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2013 - 2018 Intel Corporation. */
+/* Copyright(c) 2013 - 2019 Intel Corporation. */
 
 #ifndef _FM10K_TLV_H_
 #define _FM10K_TLV_H_
@@ -76,8 +76,8 @@ struct fm10k_tlv_attr {
 #define FM10K_TLV_ATTR_S32(id)		    { id, FM10K_TLV_SIGNED, 4 }
 #define FM10K_TLV_ATTR_S64(id)		    { id, FM10K_TLV_SIGNED, 8 }
 #define FM10K_TLV_ATTR_LE_STRUCT(id, len)   { id, FM10K_TLV_LE_STRUCT, len }
-#define FM10K_TLV_ATTR_NESTED(id)	    { id, FM10K_TLV_NESTED }
-#define FM10K_TLV_ATTR_LAST		    { FM10K_TLV_ERROR }
+#define FM10K_TLV_ATTR_NESTED(id)	    { id, FM10K_TLV_NESTED, 0 }
+#define FM10K_TLV_ATTR_LAST		    { FM10K_TLV_ERROR, 0, 0 }
 
 struct fm10k_msg_data {
 	unsigned int		    id;
-- 
2.18.0.219.gaf81d287a9da

