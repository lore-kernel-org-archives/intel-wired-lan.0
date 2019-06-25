From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Tue, 25 Jun 2019 11:44:01 -0700
Subject: [Intel-wired-lan] [PATCH 00/11] XDP unaligned chunk placement
 support
In-Reply-To: <20190620083924.1996-1-kevin.laatz@intel.com>
References: <20190620083924.1996-1-kevin.laatz@intel.com>
Message-ID: <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 20 Jun 2019, at 1:39, Kevin Laatz wrote:

> This patchset adds the ability to use unaligned chunks in the XDP 
> umem.
>
> Currently, all chunk addresses passed to the umem are masked to be 
> chunk
> size aligned (default is 2k, max is PAGE_SIZE). This limits where we 
> can
> place chunks within the umem as well as limiting the packet sizes that 
> are
> supported.
>
> The changes in this patchset removes these restrictions, allowing XDP 
> to be
> more flexible in where it can place a chunk within a umem. By relaxing 
> where
> the chunks can be placed, it allows us to use an arbitrary buffer size 
> and
> place that wherever we have a free address in the umem. These changes 
> add the
> ability to support jumboframes and make it easy to integrate with 
> other
> existing frameworks that have their own memory management systems, 
> such as
> DPDK.

I'm a little unclear on how this should work, and have a few issues 
here:

  1) There isn't any support for the user defined umem->headroom

  2) When queuing RX buffers, the handle (aka umem offset) is used, 
which
     points to the start of the buffer area.  When the buffer appears in
     the completion queue, handle points to the start of the received 
data,
     which might be different from the buffer start address.

     Normally, this RX address is just put back in the fill queue, and 
the
     mask is used to find the buffer start address again.  This no 
longer
     works, so my question is, how is the buffer start address 
recomputed
     from the actual data payload address?

     Same with TX - if the TX payload isn't aligned in with the start of
     the buffer, what happens?

  3) This appears limited to crossing a single page boundary, but there
     is no constraint check on chunk_size.
-- 
Jonathan

>
> Structure of the patchset:
> Patch 1:
>   - Remove unnecessary masking and headroom addition during zero-copy 
> Rx
>     buffer recycling in i40e. This change is required in order for the
>     buffer recycling to work in the unaligned chunk mode.
>
> Patch 2:
>   - Remove unnecessary masking and headroom addition during
>     zero-copy Rx buffer recycling in ixgbe. This change is required in
>     order for the  buffer recycling to work in the unaligned chunk 
> mode.
>
> Patch 3:
>   - Adds an offset parameter to zero_copy_allocator. This change will
>     enable us to calculate the original handle in zca_free. This will 
> be
>     required for unaligned chunk mode since we can't easily mask back 
> to
>     the original handle.
>
> Patch 4:
>   - Adds the offset parameter to i40e_zca_free. This change is needed 
> for
>     calculating the handle since we can't easily mask back to the 
> original
>     handle like we can in the aligned case.
>
> Patch 5:
>   - Adds the offset parameter to ixgbe_zca_free. This change is needed 
> for
>     calculating the handle since we can't easily mask back to the 
> original
>     handle like we can in the aligned case.
>
>
> Patch 6:
>   - Add infrastructure for unaligned chunks. Since we are dealing
>     with unaligned chunks that could potentially cross a physical page
>     boundary, we add checks to keep track of that information. We can
>     later use this information to correctly handle buffers that are
>     placed at an address where they cross a page boundary.
>
> Patch 7:
>   - Add flags for umem configuration to libbpf
>
> Patch 8:
>   - Modify xdpsock application to add a command line option for
>     unaligned chunks
>
> Patch 9:
>   - Addition of command line argument to pass in a desired buffer size
>     and buffer recycling for unaligned mode. Passing in a buffer size 
> will
>     allow the application to use unaligned chunks with the unaligned 
> chunk
>     mode. Since we are now using unaligned chunks, we need to recycle 
> our
>     buffers in a slightly different way.
>
> Patch 10:
>   - Adds hugepage support to the xdpsock application
>
> Patch 11:
>   - Documentation update to include the unaligned chunk scenario. We 
> need
>     to explicitly state that the incoming addresses are only masked in 
> the
>     aligned chunk mode and not the unaligned chunk mode.
>
> Kevin Laatz (11):
>   i40e: simplify Rx buffer recycle
>   ixgbe: simplify Rx buffer recycle
>   xdp: add offset param to zero_copy_allocator
>   i40e: add offset to zca_free
>   ixgbe: add offset to zca_free
>   xsk: add support to allow unaligned chunk placement
>   libbpf: add flags to umem config
>   samples/bpf: add unaligned chunks mode support to xdpsock
>   samples/bpf: add buffer recycling for unaligned chunks to xdpsock
>   samples/bpf: use hugepages in xdpsock app
>   doc/af_xdp: include unaligned chunk case
>
>  Documentation/networking/af_xdp.rst           | 10 +-
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 21 ++--
>  drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  3 +-
>  .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  3 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 21 ++--
>  include/net/xdp.h                             |  3 +-
>  include/net/xdp_sock.h                        |  2 +
>  include/uapi/linux/if_xdp.h                   |  4 +
>  net/core/xdp.c                                | 11 ++-
>  net/xdp/xdp_umem.c                            | 17 ++--
>  net/xdp/xsk.c                                 | 60 +++++++++--
>  net/xdp/xsk_queue.h                           | 60 +++++++++--
>  samples/bpf/xdpsock_user.c                    | 99 
> ++++++++++++++-----
>  tools/include/uapi/linux/if_xdp.h             |  4 +
>  tools/lib/bpf/xsk.c                           |  7 ++
>  tools/lib/bpf/xsk.h                           |  2 +
>  16 files changed, 241 insertions(+), 86 deletions(-)
>
> -- 
> 2.17.1
