From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri, 26 Nov 2021 16:54:08 +0100
Subject: [Intel-wired-lan] [PATCH net-next 1/2] igc: AF_XDP zero-copy
 metadata adjust breaks SKBs on XDP_PASS
In-Reply-To: <66f62ef7-f4c6-08df-a8e1-dbbe34b9b125@redhat.com>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <163700858579.565980.15265721798644582439.stgit@firesoul>
 <YaD8UHOxHasBkqEW@boxer> <66f62ef7-f4c6-08df-a8e1-dbbe34b9b125@redhat.com>
Message-ID: <20211126155408.147211-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Fri, 26 Nov 2021 16:32:47 +0100

> On 26/11/2021 16.25, Maciej Fijalkowski wrote:
> > On Mon, Nov 15, 2021 at 09:36:25PM +0100, Jesper Dangaard Brouer wrote:
> >> Driver already implicitly supports XDP metadata access in AF_XDP
> >> zero-copy mode, as xsk_buff_pool's xp_alloc() naturally set xdp_buff
> >> data_meta equal data.
> >>
> >> This works fine for XDP and AF_XDP, but if a BPF-prog adjust via
> >> bpf_xdp_adjust_meta() and choose to call XDP_PASS, then igc function
> >> igc_construct_skb_zc() will construct an invalid SKB packet. The
> >> function correctly include the xdp->data_meta area in the memcpy, but
> >> forgot to pull header to take metasize into account.
> >>
> >> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> >> Signed-off-by: Jesper Dangaard Brouer<brouer@redhat.com>
> > Acked-by: Maciej Fijalkowski<maciej.fijalkowski@intel.com>
> > 
> > Great catch. Will take a look at other ZC enabled Intel drivers if they
> > are affected as well.

They are. We'll cover them in a separate series, much thanks for
revealing that (:

> Thanks a lot for taking this task!!! :-)
> --Jesper

Al
