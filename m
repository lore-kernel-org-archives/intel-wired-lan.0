From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Thu, 25 Jul 2019 10:08:25 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v3 03/11] xsk: add support to
 allow unaligned chunk placement
In-Reply-To: <20190724051043.14348-4-kevin.laatz@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190724051043.14348-4-kevin.laatz@intel.com>
Message-ID: <c3159739-2483-b2d8-541f-6f6611a782e1@mellanox.com>
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

<...>

> +
> +static inline u64 xsk_umem_handle_offset(struct xdp_umem *umem, u64 handle,
> +					 u64 offset)
> +{
> +	if (umem->flags & XDP_UMEM_UNALIGNED_CHUNKS)
> +		return handle |= (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
> +	else
> +		return handle += offset;
> +}

|= and += are not necessary here, | and + are enough.

In the unaligned mode, it's not supported to run xsk_umem_handle_offset 
multiple times, and it's assumed that offset is zero. I'll explain the 
need in my following comment to patch 6.

<...>
