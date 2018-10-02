From: William Tu <u9012063@gmail.com>
Date: Tue, 2 Oct 2018 11:26:24 -0700
Subject: [Intel-wired-lan] [PATCH v2 3/5] ixgbe: add AF_XDP zero-copy Rx
 support
In-Reply-To: <20181002080034.11754-4-bjorn.topel@gmail.com>
References: <20181002080034.11754-1-bjorn.topel@gmail.com>
 <20181002080034.11754-4-bjorn.topel@gmail.com>
Message-ID: <CALDO+SZ2oPUBwYtBRrVdQTiCcFKaYJVd47VdKQUPWGyidUpmYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 2, 2018 at 1:01 AM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> This patch adds zero-copy Rx support for AF_XDP sockets. Instead of
> allocating buffers of type MEM_TYPE_PAGE_SHARED, the Rx frames are
> allocated as MEM_TYPE_ZERO_COPY when AF_XDP is enabled for a certain
> queue.
>
> All AF_XDP specific functions are added to a new file, ixgbe_xsk.c.
>
> Note that when AF_XDP zero-copy is enabled, the XDP action XDP_PASS
> will allocate a new buffer and copy the zero-copy frame prior passing
> it to the kernel stack.
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---

Thanks!
Tested-by: William Tu <u9012063@gmail.com>

>  drivers/net/ethernet/intel/ixgbe/Makefile     |   3 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  27 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  17 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  78 ++-
>  .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  15 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 628 ++++++++++++++++++
>  6 files changed, 747 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>
