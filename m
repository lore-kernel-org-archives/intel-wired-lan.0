From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 May 2021 21:43:50 +0200
Subject: [Intel-wired-lan] [PATCH] virtchnl: Add missing padding to
 virtchnl_proto_hdrs
Message-ID: <20210519194350.1854798-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On m68k (Coldfire M547x):

      CC      drivers/net/ethernet/intel/i40e/i40e_main.o
    In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
		     from drivers/net/ethernet/intel/i40e/i40e.h:41,
		     from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
    include/linux/avf/virtchnl.h:153:36: warning: division by zero [-Wdiv-by-zero]
      153 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
	  |                                    ^
    include/linux/avf/virtchnl.h:844:1: note: in expansion of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
      844 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
	  | ^~~~~~~~~~~~~~~~~~~~~~~~~
    include/linux/avf/virtchnl.h:844:33: error: enumerator value for ?virtchnl_static_assert_virtchnl_proto_hdrs? is not an integer constant
      844 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
	  |                                 ^~~~~~~~~~~~~~~~~~~

On m68k, integers are aligned on addresses that are multiples of two,
not four, bytes.  Hence the size of a structure containing integers may
not be divisible by 4.

Fix this by adding explicit padding.

Fixes: 1f7ea1cd6a374842 ("ice: Enable FDIR Configure for AVF")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 include/linux/avf/virtchnl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 565deea6ffe88b99..8612f8fc86c1db21 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -830,6 +830,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_proto_hdr);
 
 struct virtchnl_proto_hdrs {
 	u8 tunnel_level;
+	u8 pad[3];
 	/**
 	 * specify where protocol header start from.
 	 * 0 - from the outer layer
-- 
2.25.1

