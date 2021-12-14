From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 14 Dec 2021 15:46:19 +0100
Subject: [Intel-wired-lan] [PATCH v2 intel-net 0/6] ice: xsk: Rx
 processing fixes
In-Reply-To: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
References: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
Message-ID: <CAJ8uoz0Fb-hciySWAy79X2d_H=oUddbFGCm3RUAtRYhUQ5-K5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 13, 2021 at 4:31 PM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi there,
> it seems that previous [0] Rx fix was not enough and there are still
> issues with AF_XDP Rx ZC support in ice driver. Elza reported that for
> multiple XSK sockets configured on a single netdev, some of them were
> becoming dead after a while. We have spotted more things that needed to
> be addressed this time. More of information can be found in particular
> commit messages.
>
> v2 has a diff around only patch 2:
> - use array_size() in memsets (Alexandr)
> - remove unnecessary ternary operator from ice_alloc_rx_buf{, _zc}()
>   (Alexandr)
> - respect RCT in ice_construct_skb_zc() (Alexandr)
> - fix kdoc issue (Anthony)
>
> It also carries Alexandr's patch that was sent previously which was
> overlapping with this set.
>
> Thanks,
> Maciej
>
> [0]: https://lore.kernel.org/bpf/20211129231746.2767739-1-anthony.l.nguyen at intel.com/

Thank you so much for all these fixes Maciej and Alexandr!

BTW, ice zero-copy support in bpf and bpf-next does not work at all
without this patch set, so need to get this in as soon as possible.
net and net-next might not work either, but have not tried.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Alexander Lobakin (1):
>   ice: remove dead store on XSK hotpath
>
> Maciej Fijalkowski (5):
>   ice: xsk: return xsk buffers back to pool when cleaning the ring
>   ice: xsk: allocate separate memory for XDP SW ring
>   ice: xsk: do not clear status_error0 for ntu + nb_buffs descriptor
>   ice: xsk: allow empty Rx descriptors on XSK ZC data path
>   ice: xsk: fix cleaned_count setting
>
>  drivers/net/ethernet/intel/ice/ice_base.c | 17 ++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 19 ++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
>  drivers/net/ethernet/intel/ice/ice_xsk.c  | 66 +++++++++++------------
>  4 files changed, 62 insertions(+), 41 deletions(-)
>
> --
> 2.33.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
