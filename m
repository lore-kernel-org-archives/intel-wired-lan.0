From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Mon, 10 Jan 2022 10:11:43 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 0/9] net: intel:
 napi_alloc_skb() vs metadata
In-Reply-To: <20211208140702.642741-1-alexandr.lobakin@intel.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
Message-ID: <DM6PR11MB3292AA2C0D33C635FE9D068BF1509@DM6PR11MB3292.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 net-next 0/9] net: intel: napi_alloc_skb()
> vs metadata
> 
> This is an interpolation of [0] to other Intel Ethernet drivers (and is (re)based
> on its code).
> The main aim is to keep XDP metadata not only in case with build_skb(), but
> also when we do napi_alloc_skb() + memcpy().
> 
> All Intel drivers suffers from the same here:
>  - metadata gets lost on XDP_PASS in legacy-rx;
>  - excessive headroom allocation on XSK Rx to skbs;
>  - metadata gets lost on XSK Rx to skbs.
> 
> Those get especially actual in XDP Hints upcoming.
> I couldn't have addressed the first one for all Intel drivers due to that they
> don't reserve any headroom for now in legacy-rx mode even with XDP
> enabled. This is hugely wrong, but requires quite a bunch of work and a
> separate series. Luckily, ice doesn't suffer from that.
> igc has 1 and 3 already fixed in [0].
> 
> From v3 ([1]):
>  - fix driver name and ixgbe_construct_skb() function name in the
>    commit message of #9 (Jesper);
>  - no functional changes.
> 
> From v2 (unreleased upstream):
>  - tweaked 007 to pass bi->xdp directly and simplify code (Maciej);
>  - picked Michal's Reviewed-by.
> 
> From v1 (unreleased upstream):
>  - drop "fixes" of legacy-rx for i40e, igb and ixgbe since they have
>    another flaw regarding headroom (see above);
>  - drop igc cosmetic fixes since they landed upstream incorporated
>    into Jesper's commits;
>  - picked one Acked-by from Maciej.
> 
> [0]
> https://lore.kernel.org/netdev/163700856423.565980.101625649213476937
> 58.stgit at firesoul
> [1] https://lore.kernel.org/netdev/20211207205536.563550-1-
> alexandr.lobakin at intel.com
> 
> Alexander Lobakin (9):
>   i40e: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
>   i40e: respect metadata on XSK Rx to skb
>   ice: respect metadata in legacy-rx/ice_construct_skb()
>   ice: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
>   ice: respect metadata on XSK Rx to skb
>   igc: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
>   ixgbe: pass bi->xdp to ixgbe_construct_skb_zc() directly
>   ixgbe: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
>   ixgbe: respect metadata on XSK Rx to skb
> 
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 16 +++++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 15 ++++++++---
>  drivers/net/ethernet/intel/ice/ice_xsk.c     | 16 +++++++-----
>  drivers/net/ethernet/intel/igc/igc_main.c    | 13 +++++-----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 27 ++++++++++++--------
>  5 files changed, 54 insertions(+), 33 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
