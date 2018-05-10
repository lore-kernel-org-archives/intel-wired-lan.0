From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:39 -0700
Subject: [Intel-wired-lan] [next PATCH S91 01/11] virtchnl: Whitespace and
 parenthesis cleanup
Message-ID: <20180510125949.79823-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Clean up existing instances of unnecessary parentheses in if
statement and change order of conditionals to make it easier to read

The opening /* should be followed by a single space and the closing */
should be preceded with a single space.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b0a7f31..212b382 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -485,7 +485,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
 struct virtchnl_rss_lut {
 	u16 vsi_id;
 	u16 lut_entries;
-	u8 lut[1];        /* RSS lookup table*/
+	u8 lut[1];        /* RSS lookup table */
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
@@ -819,7 +819,7 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		return VIRTCHNL_ERR_PARAM;
 	}
 	/* few more checks */
-	if ((valid_len != msglen) || (err_msg_format))
+	if (err_msg_format || valid_len != msglen)
 		return VIRTCHNL_STATUS_ERR_OPCODE_MISMATCH;
 
 	return 0;
-- 
2.9.5

