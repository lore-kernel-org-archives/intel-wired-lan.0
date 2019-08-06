From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Aug 2019 12:52:51 -0700
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <20190806.113640.171591509807004446.davem@davemloft.net>
References: <20190806092919.13211-1-firo.yang@suse.com>
 <20190806.113640.171591509807004446.davem@davemloft.net>
Message-ID: <CAKgT0UctiHjKxGXHJEiJX4_aEJt1swBAxMOKPT9huXBOcf+2VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 6, 2019 at 11:36 AM David Miller <davem@davemloft.net> wrote:
>
> From: Firo Yang <firo.yang@suse.com>
> Date: Tue, 6 Aug 2019 09:29:51 +0000
>
> > In Xen environment, if Xen-swiotlb is enabled, ixgbe driver
> > could possibly allocate a page, DMA memory buffer, for the first
> > fragment which is not suitable for Xen-swiotlb to do DMA operations.
> > Xen-swiotlb will internally allocate another page for doing DMA
> > operations. It requires syncing between those two pages. Otherwise,
> > we may get an incomplete skb. To fix this problem, sync the first
> > fragment no matter the first fargment is makred as "page_released"
> > or not.
> >
> > Signed-off-by: Firo Yang <firo.yang@suse.com>
>
> I don't understand, an unmap operation implies a sync operation.

Actually it doesn't because ixgbe is mapping and unmapping with
DMA_ATTR_SKIP_CPU_SYNC.

The patch description isn't very good. The issue is that the sync in
this case is being skipped in ixgbe_get_rx_buffer for a frame where
the buffer spans more then a single page. As such we need to do both
the sync and the unmap call on the last frame when we encounter the
End Of Packet.
