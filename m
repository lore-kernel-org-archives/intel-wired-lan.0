From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 19 May 2021 15:16:00 -0700
Subject: [Intel-wired-lan] [PATCH] virtchnl: Add missing padding to
 virtchnl_proto_hdrs
In-Reply-To: <20210519194350.1854798-1-geert@linux-m68k.org>
References: <20210519194350.1854798-1-geert@linux-m68k.org>
Message-ID: <20210519151600.00006065@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Geert Uytterhoeven wrote:

> On m68k (Coldfire M547x):
> 
>       CC      drivers/net/ethernet/intel/i40e/i40e_main.o
>     In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
> 		     from drivers/net/ethernet/intel/i40e/i40e.h:41,
> 		     from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
>     include/linux/avf/virtchnl.h:153:36: warning: division by zero [-Wdiv-by-zero]
>       153 |  { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
> 	  |                                    ^
>     include/linux/avf/virtchnl.h:844:1: note: in expansion of macro ?VIRTCHNL_CHECK_STRUCT_LEN?
>       844 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
> 	  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/avf/virtchnl.h:844:33: error: enumerator value for ?virtchnl_static_assert_virtchnl_proto_hdrs? is not an integer constant
>       844 | VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
> 	  |                                 ^~~~~~~~~~~~~~~~~~~
> 
> On m68k, integers are aligned on addresses that are multiples of two,
> not four, bytes.  Hence the size of a structure containing integers may
> not be divisible by 4.
> 
> Fix this by adding explicit padding.

Thanks Geert, I checked and x86_64 adds this padding anyway, so doesn't
result in any functional changes AFAICS. In any case, this is more
correct for a structure that is part of an API (no implicit padding!)

BTW. the patch subject is a little wrong, should have been
[PATCH net]

But I think Tony can take care of that when sending to netdev list,
unless you want to send a v2.
 
> Fixes: 1f7ea1cd6a374842 ("ice: Enable FDIR Configure for AVF")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only.

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
