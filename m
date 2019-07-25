From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Thu, 25 Jul 2019 08:39:19 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v3 00/11] XDP unaligned chunk
 placement support
In-Reply-To: <20190724051043.14348-1-kevin.laatz@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
Message-ID: <94EAD717-F632-499F-8BBD-FFF5A5333CBF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 23 Jul 2019, at 22:10, Kevin Laatz wrote:

> This patch set adds the ability to use unaligned chunks in the XDP umem.
>
> Currently, all chunk addresses passed to the umem are masked to be chunk
> size aligned (max is PAGE_SIZE). This limits where we can place chunks
> within the umem as well as limiting the packet sizes that are supported.
>
> The changes in this patch set removes these restrictions, allowing XDP to
> be more flexible in where it can place a chunk within a umem. By relaxing
> where the chunks can be placed, it allows us to use an arbitrary buffer
> size and place that wherever we have a free address in the umem. These
> changes add the ability to support arbitrary frame sizes up to 4k
> (PAGE_SIZE) and make it easy to integrate with other existing frameworks
> that have their own memory management systems, such as DPDK.
> In DPDK, for example, there is already support for AF_XDP with zero-copy.
> However, with this patch set the integration will be much more seamless.
> You can find the DPDK AF_XDP driver at:
> https://git.dpdk.org/dpdk/tree/drivers/net/af_xdp
>
> Since we are now dealing with arbitrary frame sizes, we need also need to
> update how we pass around addresses. Currently, the addresses can simply be
> masked to 2k to get back to the original address. This becomes less trivial
> when using frame sizes that are not a 'power of 2' size. This patch set
> modifies the Rx/Tx descriptor format to use the upper 16-bits of the addr
> field for an offset value, leaving the lower 48-bits for the address (this
> leaves us with 256 Terabytes, which should be enough!). We only need to use
> the upper 16-bits to store the offset when running in unaligned mode.
> Rather than adding the offset (headroom etc) to the address, we will store
> it in the upper 16-bits of the address field. This way, we can easily add
> the offset to the address where we need it, using some bit manipulation and
> addition, and we can also easily get the original address wherever we need
> it (for example in i40e_zca_fr-- ee) by simply masking to get the lower
> 48-bits of the address field.

I wonder if it would be better to break backwards compatibility here and
say that a handle is going to change from [addr] to [base | offset], or
even [index | offset], where address = (index * chunk size) + offset, and
then use accessor macros to manipulate the queue entries.

This way, the XDP hotpath can adjust the handle with simple arithmetic,
bypassing the "if (unaligned)", check, as it changes the offset directly.

Using a chunk index instead of a base address is safer, otherwise it is
too easy to corrupt things.
-- 
Jonathan
