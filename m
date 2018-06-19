From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jun 2018 22:20:01 +0000
Subject: [Intel-wired-lan] [PATCH net-next] bpf,
 i40e: add meta data support
In-Reply-To: <CAKgT0Uc5di4ijZnqRAM+zN1CYuc-t5YdB4joDkDsvZ3BHADKxg@mail.gmail.com>
References: <20180528090720.8230-1-daniel@iogearbox.net>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C7FD1@ORSMSX104.amr.corp.intel.com>
 <CAKgT0UeZ_VwxYXiwBoX3e9gtARqqH+FPGG2KNm70=J82dsZBVw@mail.gmail.com>
 <CAKgT0Uc5di4ijZnqRAM+zN1CYuc-t5YdB4joDkDsvZ3BHADKxg@mail.gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C8011@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With that patch applied, it works :-) Maybe this patch needs to be merged into the older one? Just my 2 bucks... 

--Andrew


> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Tuesday, June 19, 2018 2:18 PM
> To: Bowers, AndrewX <andrewx.bowers@intel.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net-next] bpf, i40e: add meta data
> support
> 
> Try retesting with this patch also applied:
> http://patchwork.ozlabs.org/patch/928778/
> 
> Thanks.
> 
> - Alex
> 
> On Tue, Jun 19, 2018 at 2:17 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > I thought we knew this patch had an issue. I thought there was an
> > update for it wasn't there?
> >
> > I called out the line below. Basically we are just supposed to be
> > reporting I40E_SKB_PAD, but it was being doubled because that is also
> > the value represented by xdp->data - xdp->data_hard_start
> >
> > - Alex
> >
> > On Tue, Jun 19, 2018 at 11:56 AM, Bowers, AndrewX
> > <andrewx.bowers@intel.com> wrote:
> >> This patch is breaking ping, with the patch applied the ICMP packets are
> arriving corrupted on the receiving end. Reverting the patch fixes the
> problem. Pcap file attached.
> >>
> >> --Andrew
> >>
> >>
> >>> -----Original Message-----
> >>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> >>> Behalf Of Daniel Borkmann
> >>> Sent: Monday, May 28, 2018 2:07 AM
> >>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> >>> Cc: intel-wired-lan at lists.osuosl.org; daniel at iogearbox.net
> >>> Subject: [Intel-wired-lan] [PATCH net-next] bpf, i40e: add meta data
> >>> support
> >>>
> >>> Add support for XDP meta data when using build skb variant of the
> >>> i40e driver. Implementation is analogous to the existing ixgbe and
> >>> ixgbevf support for meta data from 366a88fe2f40 ("bpf,
> >>> ixgbe: add meta data support") and be8333322eff ("ixgbevf: Add
> >>> support for meta data"). With the build skb variant we get
> >>> 192 bytes of extra headroom which can be used for encaps or meta data.
> >>>
> >>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >>> Acked-by: John Fastabend <john.fastabend@gmail.com>
> >>> Tested-by: John Fastabend <john.fastabend@gmail.com>
> >>> ---
> >>>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 39
> >>> +++++++++++++++++++++++------
> >>>  1 file changed, 31 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> >>> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> >>> index 9b698c5..eee6e91 100644
> >>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> >>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> >>> @@ -2032,6 +2032,21 @@ static struct sk_buff
> >>> *i40e_construct_skb(struct i40e_ring *rx_ring,  #if L1_CACHE_BYTES <
> 128
> >>>       prefetch(xdp->data + L1_CACHE_BYTES);  #endif
> >>> +     /* Note, we get here by enabling legacy-rx via:
> >>> +      *
> >>> +      *    ethtool --set-priv-flags <dev> legacy-rx on
> >>> +      *
> >>> +      * In this mode, we currently get 0 extra XDP headroom as
> >>> +      * opposed to having legacy-rx off, where we process XDP
> >>> +      * packets going to stack via i40e_build_skb(). The latter
> >>> +      * provides us currently with 192 bytes of headroom.
> >>> +      *
> >>> +      * For i40e_construct_skb() mode it means that the
> >>> +      * xdp->data_meta will always point to xdp->data, since
> >>> +      * the helper cannot expand the head. Should this ever
> >>> +      * change in future for legacy-rx mode on, then lets also
> >>> +      * add xdp->data_meta handling here.
> >>> +      */
> >>>
> >>>       /* allocate a skb to store the frags */
> >>>       skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
> >>> @@ -2083,19 +2098,25 @@ static struct sk_buff *i40e_build_skb(struct
> >>> i40e_ring *rx_ring,
> >>>                                     struct i40e_rx_buffer *rx_buffer,
> >>>                                     struct xdp_buff *xdp)  {
> >>> -     unsigned int size = xdp->data_end - xdp->data;
> >>> +     unsigned int metasize = xdp->data - xdp->data_meta;
> >>>  #if (PAGE_SIZE < 8192)
> >>>       unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;  #else
> >>>       unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct
> >>> skb_shared_info)) +
> >>> -                             SKB_DATA_ALIGN(I40E_SKB_PAD + size);
> >>> +                             SKB_DATA_ALIGN(I40E_SKB_PAD +
> >>> +                                            (xdp->data_end -
> >>> +
> >>> + xdp->data_hard_start));
> >>>  #endif
> >>>       struct sk_buff *skb;
> >>>
> >>> -     /* prefetch first cache line of first page */
> >>> -     prefetch(xdp->data);
> >>> +     /* Prefetch first cache line of first page. If xdp->data_meta
> >>> +      * is unused, this points extactly as xdp->data, otherwise we
> >>> +      * likely have a consumer accessing first few bytes of meta
> >>> +      * data, and then actual data.
> >>> +      */
> >>> +     prefetch(xdp->data_meta);
> >>>  #if L1_CACHE_BYTES < 128
> >>> -     prefetch(xdp->data + L1_CACHE_BYTES);
> >>> +     prefetch(xdp->data_meta + L1_CACHE_BYTES);
> >>>  #endif
> >>>       /* build an skb around the page buffer */
> >>>       skb = build_skb(xdp->data_hard_start, truesize); @@ -2103,8
> >>> +2124,10 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring
> >>> +*rx_ring,
> >>>               return NULL;
> >>>
> >>>       /* update pointers within the skb to store the data */
> >>> -     skb_reserve(skb, I40E_SKB_PAD);
> >>> -     __skb_put(skb, size);
> >>> +     skb_reserve(skb, I40E_SKB_PAD + (xdp->data - xdp-
> >>> >data_hard_start));
> >
> > The problem is here if I recall.
> >
> > This should be skb_reserve(skb, xdp->data - xdp - data_hard_start);
> >
> >>> +     __skb_put(skb, xdp->data_end - xdp->data);
> >>> +     if (metasize)
> >>> +             skb_metadata_set(skb, metasize);
> >>>
> >>>       /* buffer is used by skb, update page_offset */  #if
> >>> (PAGE_SIZE <
> >>> 8192) @@ -2341,7 +2364,7 @@ static int i40e_clean_rx_irq(struct
> >>> i40e_ring *rx_ring, int budget)
> >>>               if (!skb) {
> >>>                       xdp.data = page_address(rx_buffer->page) +
> >>>                                  rx_buffer->page_offset;
> >>> -                     xdp_set_data_meta_invalid(&xdp);
> >>> +                     xdp.data_meta = xdp.data;
> >>>                       xdp.data_hard_start = xdp.data -
> >>>                                             i40e_rx_offset(rx_ring);
> >>>                       xdp.data_end = xdp.data + size;
> >>> --
> >>> 2.9.5
> >>>
> >>> _______________________________________________
> >>> Intel-wired-lan mailing list
> >>> Intel-wired-lan at osuosl.org
> >>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> >>
> >> _______________________________________________
> >> Intel-wired-lan mailing list
> >> Intel-wired-lan at osuosl.org
> >> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> >>
