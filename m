From: David Miller <davem@davemloft.net>
Date: Tue, 06 Aug 2019 11:36:40 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <20190806092919.13211-1-firo.yang@suse.com>
References: <20190806092919.13211-1-firo.yang@suse.com>
Message-ID: <20190806.113640.171591509807004446.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Firo Yang <firo.yang@suse.com>
Date: Tue, 6 Aug 2019 09:29:51 +0000

> In Xen environment, if Xen-swiotlb is enabled, ixgbe driver
> could possibly allocate a page, DMA memory buffer, for the first
> fragment which is not suitable for Xen-swiotlb to do DMA operations.
> Xen-swiotlb will internally allocate another page for doing DMA
> operations. It requires syncing between those two pages. Otherwise,
> we may get an incomplete skb. To fix this problem, sync the first
> fragment no matter the first fargment is makred as "page_released"
> or not.
> 
> Signed-off-by: Firo Yang <firo.yang@suse.com>

I don't understand, an unmap operation implies a sync operation.
