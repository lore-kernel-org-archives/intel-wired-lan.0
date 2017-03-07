From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 18:31:10 +0000
Subject: [Intel-wired-lan] [next PATCH] ixgbe: Add support for maximum
 headroom when using build_skb
In-Reply-To: <20170302230105.8817.27738.stgit@localhost.localdomain>
References: <20170302230105.8817.27738.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401F96@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, March 2, 2017 3:01 PM
> To: Fastabend, John R <john.r.fastabend@intel.com>; intel-wired-
> lan at lists.osuosl.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH] ixgbe: Add support for maximum
> headroom when using build_skb
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch increases the headroom allocated when using build_skb on a
> system with 4K pages.  Specifically the breakdown of headroom versus cache
> size is as follows:
>     L1 Cache Size           Headroom
>     64                      192
>     64, NET_IP_ALIGN == 2   194
>     128                     128
>     128, NET_IP_ALIGN == 2  130
>     256                     512
>     256, NET_IP_ALIGN == 2  258
> 
> I stopped at supporting only a cache line size of 256 as that was the largest
> cache size I could find supported in the kernel.
> 
> With this we are guaranteeing at least 128 bytes of headroom to spare in the
> frame.  This should be enough for us to insert a couple of IPv6 headers if
> needed which is likely enough room for anything XDP should need.
> 
> I'm leaving the padding for systems with pages larger than 4K unmodified for
> now.  XDP currently isn't really setup to work on those types of systems so
> we can cross that bridge when we get there.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   55
> +++++++++++++++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    6 +--
>  2 files changed, 53 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


