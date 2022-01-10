From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Mon, 10 Jan 2022 10:13:17 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 4/9] ice: don't reserve
 excessive XDP_PACKET_HEADROOM on XSK Rx to skb
In-Reply-To: <20211208140702.642741-5-alexandr.lobakin@intel.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-5-alexandr.lobakin@intel.com>
Message-ID: <DM6PR11MB3292FE1773DEDE04685C35FAF1509@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Wednesday, December 8, 2021 7:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Song Liu <songliubraving@fb.com>; Jesper Dangaard Brouer
> <hawk@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Yonghong
> Song <yhs@fb.com>; Martin KaFai Lau <kafai@fb.com>; John Fastabend
> <john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; Andrii
> Nakryiko <andrii@kernel.org>; Bj?rn T?pel <bjorn@kernel.org>;
> netdev at vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; KP Singh
> <kpsingh@kernel.org>; bpf at vger.kernel.org; David S. Miller
> <davem@davemloft.net>; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v4 net-next 4/9] ice: don't reserve excessive
> XDP_PACKET_HEADROOM on XSK Rx to skb
> 
> {__,}napi_alloc_skb() allocates and reserves additional NET_SKB_PAD
> + NET_IP_ALIGN for any skb.
> OTOH, ice_construct_skb_zc() currently allocates and reserves additional
> `xdp->data - xdp->data_hard_start`, which is XDP_PACKET_HEADROOM for
> XSK frames.
> There's no need for that at all as the frame is post-XDP and will go only to the
> networking stack core.
> Pass the size of the actual data only to __napi_alloc_skb() and don't reserve
> anything. This will give enough headroom for stack processing.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
