From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 22 Apr 2020 18:50:26 +0000
Subject: [Intel-wired-lan] [PATCH] virtchnl: Add missing explicit
 padding to structures
In-Reply-To: <20200416095049.12917-1-geert@linux-m68k.org>
References: <20200416095049.12917-1-geert@linux-m68k.org>
Message-ID: <1e732391d4e94bbc87ab01ee80934fd3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Geert Uytterhoeven
Sent: Thursday, April 16, 2020 2:51 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller <davem@davemloft.net>
Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org; Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [Intel-wired-lan] [PATCH] virtchnl: Add missing explicit padding to structures

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
Exposed by the "select PCI" in commit 4be5e8648b0c287a ("media: move CEC platform drivers to a separate directory").
---
 include/linux/avf/virtchnl.h | 5 +++++
 1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



