From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2020 11:50:49 +0200
Subject: [Intel-wired-lan] [PATCH] virtchnl: Add missing explicit padding to
 structures
Message-ID: <20200416095049.12917-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On e.g. m68k, the alignment of 32-bit values is only 2 bytes, leading
to:

    ./include/linux/avf/virtchnl.h:147:36: warning: division by zero [-Wdiv-by-zero]
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
					^
    ./include/linux/avf/virtchnl.h:577:1: note: in expansion of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
     VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:577:32: error: enumerator value for ?virtchnl_static_assert_virtchnl_filter? is not an integer constant
     VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
				    ^~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:147:53: note: in definition of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
							 ^
    ./include/linux/avf/virtchnl.h:147:36: warning: division by zero [-Wdiv-by-zero]
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
					^
    ./include/linux/avf/virtchnl.h:619:1: note: in expansion of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
     VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_pf_event);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:619:31: error: enumerator value for ?virtchnl_static_assert_virtchnl_pf_event? is not an integer constant
     VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_pf_event);
				   ^~~~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:147:53: note: in definition of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
							 ^
    ./include/linux/avf/virtchnl.h:147:36: warning: division by zero [-Wdiv-by-zero]
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
					^
    ./include/linux/avf/virtchnl.h:640:1: note: in expansion of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
     VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_iwarp_qv_info);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:640:31: error: enumerator value for ?virtchnl_static_assert_virtchnl_iwarp_qv_info? is not an integer constant
     VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_iwarp_qv_info);
				   ^~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:147:53: note: in definition of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
							 ^
    ./include/linux/avf/virtchnl.h:147:36: warning: division by zero [-Wdiv-by-zero]
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
					^
    ./include/linux/avf/virtchnl.h:647:1: note: in expansion of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
     VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_iwarp_qvlist_info);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:647:31: error: enumerator value for ?virtchnl_static_assert_virtchnl_iwarp_qvlist_info? is not an integer constant
     VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_iwarp_qvlist_info);
				   ^~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/avf/virtchnl.h:147:53: note: in definition of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
      { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
							 ^

Fix this by adding explicit padding to structures with holes.

Reported-by: noreply at ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Exposed by the "select PCI" in commit 4be5e8648b0c287a ("media: move CEC
platform drivers to a separate directory").
---
 include/linux/avf/virtchnl.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index ca956b672ac0f759..40bad71865ea7628 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -476,6 +476,7 @@ struct virtchnl_rss_key {
 	u16 vsi_id;
 	u16 key_len;
 	u8 key[1];         /* RSS hash key, packed bytes */
+	u8 pad[1];
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
@@ -484,6 +485,7 @@ struct virtchnl_rss_lut {
 	u16 vsi_id;
 	u16 lut_entries;
 	u8 lut[1];        /* RSS lookup table */
+	u8 pad[1];
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
@@ -572,6 +574,7 @@ struct virtchnl_filter {
 	enum	virtchnl_action action;
 	u32	action_meta;
 	u8	field_flags;
+	u8	pad[3];
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
@@ -610,6 +613,7 @@ struct virtchnl_pf_event {
 			/* link_speed provided in Mbps */
 			u32 link_speed;
 			u8 link_status;
+			u8 pad[3];
 		} link_event_adv;
 	} event_data;
 
@@ -635,6 +639,7 @@ struct virtchnl_iwarp_qv_info {
 	u16 ceq_idx;
 	u16 aeq_idx;
 	u8 itr_idx;
+	u8 pad[3];
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_iwarp_qv_info);
-- 
2.17.1

