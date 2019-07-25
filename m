From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Thu, 25 Jul 2019 09:27:04 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v3 03/11] xsk: add support to
 allow unaligned chunk placement
In-Reply-To: <20190724051043.14348-4-kevin.laatz@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190724051043.14348-4-kevin.laatz@intel.com>
Message-ID: <3af74e26-8899-cf1e-6fd4-5ea0bd349fc3@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-24 08:10, Kevin Laatz wrote:
> Currently, addresses are chunk size aligned. This means, we are very
> restricted in terms of where we can place chunk within the umem. For
> example, if we have a chunk size of 2k, then our chunks can only be placed
> at 0,2k,4k,6k,8k... and so on (ie. every 2k starting from 0).
> 
> This patch introduces the ability to use unaligned chunks. With these
> changes, we are no longer bound to having to place chunks at a 2k (or
> whatever your chunk size is) interval. Since we are no longer dealing with
> aligned chunks, they can now cross page boundaries. Checks for page
> contiguity have been added in order to keep track of which pages are
> followed by a physically contiguous page.
> 
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> ---
> v2:
>    - Add checks for the flags coming from userspace
>    - Fix how we get chunk_size in xsk_diag.c
>    - Add defines for masking the new descriptor format
>    - Modified the rx functions to use new descriptor format
>    - Modified the tx functions to use new descriptor format
> 
> v3:
>    - Add helper function to do address/offset masking/addition
> ---
>   include/net/xdp_sock.h      | 17 ++++++++
>   include/uapi/linux/if_xdp.h |  9 ++++
>   net/xdp/xdp_umem.c          | 18 +++++---
>   net/xdp/xsk.c               | 86 ++++++++++++++++++++++++++++++-------
>   net/xdp/xsk_diag.c          |  2 +-
>   net/xdp/xsk_queue.h         | 68 +++++++++++++++++++++++++----
>   6 files changed, 170 insertions(+), 30 deletions(-)
> 

<...>

> +/* If a buffer crosses a page boundary, we need to do 2 memcpy's, one for
> + * each page. This is only required in copy mode.
> + */
> +static void __xsk_rcv_memcpy(struct xdp_umem *umem, u64 addr, void *from_buf,
> +			     u32 len, u32 metalen)
> +{
> +	void *to_buf = xdp_umem_get_data(umem, addr);
> +
> +	if (xskq_crosses_non_contig_pg(umem, addr, len + metalen)) {
> +		void *next_pg_addr = umem->pages[(addr >> PAGE_SHIFT) + 1].addr;
> +		u64 page_start = addr & (PAGE_SIZE - 1);
> +		u64 first_len = PAGE_SIZE - (addr - page_start);

Let addr = 0x12345, PAGE_SIZE = 0x1000, len = 0x1000. Your calculations 
lead to page_start = 0x345, first_len = 0x1000 - 0x12000, which is 
negative. I think page_start is calculated incorrectly (is ~ missing?).

> +
> +		memcpy(to_buf, from_buf, first_len + metalen);
> +		memcpy(next_pg_addr, from_buf + first_len, len - first_len);
> +
> +		return;
> +	}
> +
> +	memcpy(to_buf, from_buf, len + metalen);
> +}
> +

<...>

> +static inline bool xskq_is_valid_addr_unaligned(struct xsk_queue *q, u64 addr,
> +						u64 length,
> +						struct xdp_umem *umem)
> +{
> +	addr += addr >> XSK_UNALIGNED_BUF_OFFSET_SHIFT;
> +	addr &= XSK_UNALIGNED_BUF_ADDR_MASK;
> +	if (addr >= q->size ||

Addresses like 0x00aaffffffffffff will pass the validation (0xaa + 
0xffffffffffff will overflow mod 2^48 and become a small number), 
whereas such addresses don't look valid for me.

> +	    xskq_crosses_non_contig_pg(umem, addr, length)) {

If the region is not contiguous, we cant RX into it - that's clear. 
However, how can the userspace determine whether these two pages of UMEM 
are mapped contiguously in the DMA space? Are we going to silently drop 
descriptors to non-contiguous frames and leak them? Please explain how 
to use it correctly from the application side.

> +		q->invalid_descs++;
> +		return false;
> +	}
> +
> +	return true;
> +}

<...>

