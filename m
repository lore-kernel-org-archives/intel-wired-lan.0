From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Mon, 27 Dec 2021 22:34:10 +0200
Subject: [Intel-wired-lan] [PATCH v4 net-next 6/9] igc: don't reserve
 excessive XDP_PACKET_HEADROOM on XSK Rx to skb
In-Reply-To: <20211208140702.642741-7-alexandr.lobakin@intel.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-7-alexandr.lobakin@intel.com>
Message-ID: <e7145513-1808-fb59-35cc-37169ecec047@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/8/2021 16:06, Alexander Lobakin wrote:
> {__,}napi_alloc_skb() allocates and reserves additional NET_SKB_PAD
> + NET_IP_ALIGN for any skb.
> OTOH, igc_construct_skb_zc() currently allocates and reserves
> additional `xdp->data_meta - xdp->data_hard_start`, which is about
> XDP_PACKET_HEADROOM for XSK frames.
> There's no need for that at all as the frame is post-XDP and will
> go only to the networking stack core.
> Pass the size of the actual data only (+ meta) to
> __napi_alloc_skb() and don't reserve anything. This will give
> enough headroom for stack processing.
> Also, net_prefetch() xdp->data_meta and align the copy size to
> speed-up memcpy() a little and better match igc_costruct_skb().
> 
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

