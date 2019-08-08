From: Firo Yang <firo.yang@suse.com>
Date: Thu, 8 Aug 2019 01:55:31 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <CAKgT0UfEh8cvTht3yceyXqwReJOQkcpJV8j0vHSJwookTWhn_Q@mail.gmail.com>
References: <20190807024917.27682-1-firo.yang@suse.com>
 <85aaefdf-d454-1823-5840-d9e2f71ffb19@oracle.com>
 <20190807083831.GA6811@linux-6qg8> <20190807160853.00001d71@gmail.com>
 <CAKgT0UfEh8cvTht3yceyXqwReJOQkcpJV8j0vHSJwookTWhn_Q@mail.gmail.com>
Message-ID: <20190808015521.GA18282@linux-6qg8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 08/07/2019 09:06, Alexander Duyck wrote:
> On Wed, Aug 7, 2019 at 7:09 AM Maciej Fijalkowski
> <maciejromanfijalkowski@gmail.com> wrote:
> >
> > On Wed, 7 Aug 2019 08:38:43 +0000
> > Firo Yang <firo.yang@suse.com> wrote:
> >
> > > The 08/07/2019 15:56, Jacob Wen wrote:
> > > > I think the description is not correct. Consider using something like below.
> > > Thank you for comments.
> > >
> > > >
> > > > In Xen environment, due to memory fragmentation ixgbe may allocate a 'DMA'
> > > > buffer with pages that are not physically contiguous.
> > > Actually, I didn't look into the reason why ixgbe got a DMA buffer which
> > > was mapped to Xen-swiotlb area.
> >
> > I think that neither of these descriptions are telling us what was truly
> > broken. They lack what Alexander wrote on v1 thread of this patch.
> >
> > ixgbe_dma_sync_frag is called only on case when the current descriptor has EOP
> > bit set, skb was already allocated and you'll be adding a current buffer as a
> > frag. DMA unmapping for the first frag was intentionally skipped and we will be
> > unmapping it here, in ixgbe_dma_sync_frag. As Alex said, we're using the
> > DMA_ATTR_SKIP_CPU_SYNC attribute which obliges us to perform a sync manually
> > and it was missing.
> >
> > So IMHO the commit description should include descriptions from both xen and
> > ixgbe worlds, the v2 lacks info about ixgbe case.
Thank you. Will submit v3 with what Alexander worte on v1.

Thanks,
Firo
> >
> > BTW Alex, what was the initial reason for holding off with unmapping the first
> > buffer? Asking because IIRC the i40e and ice behave a bit different here. We
> > don't look there for EOP at all when building/constructing skb and not delaying
> > the unmap of non-eop buffers.
> >
> > Thanks,
> > Maciej
> 
> The reason why we have to hold off on unmapping the first buffer is
> because in the case of Receive Side Coalescing (RSC), also known as Large
> Receive Offload (LRO), the header of the packet is updated for each
> additional frame that is added. As such you can end up with the device
> writing data, header, data, header, data, header where each data write
> would update a new descriptor, but the header will only ever update the
> first descriptor in the chain. As such if we unmapped it earlier it would
> result in an IOMMU fault because the device would be rewriting the header
> after it had been unmapped.
> 
> The devices supported by the ixgbe driver are the only ones that have
> RSC/LRO support. As such this behavior is present for ixgbe, but not for
> other Intel NIC drivers including igb, igbvf, ixgbevf, i40e, etc.
> 
> - Alex
> 
