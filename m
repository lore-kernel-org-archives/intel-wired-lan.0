From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 24 May 2017 09:31:16 -0700
Subject: [Intel-wired-lan] [PATCH v7 0/2] i40e: support for XDP
In-Reply-To: <20170524055535.14155-1-bjorn.topel@gmail.com>
References: <20170524055535.14155-1-bjorn.topel@gmail.com>
Message-ID: <CAKgT0Ud6fRk2VQ=tc5rPMarD+MM1uXMqU701K6++ti4ufi6DdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

On Tue, May 23, 2017 at 10:55 PM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> This series adds XDP support for i40e-based NICs.
>
> The first patch wires up ndo_xdp and implements XDP_DROP semantics for
> all actions. The second patch adds egress support via the XDP_TX
> action.
>
> Performance numbers (40GbE port, 64B packets) for xdp1 and xdp2
> programs, from samples/bpf/:
>
>  IOMMU                      | xdp1      | xdp2
>  ---------------------------+-----------+-----------
>  iommu=off                  | 29.7 Mpps | 17.1 Mpps
>  iommu=pt intel_iommu=on    | 29.7 Mpps | 11.6 Mpps
>  iommu=on intel_iommu=on    | 21.8 Mpps |  3.7 Mpps
>
> Future improvements, not covered by the patches:
>   * Proper debugfs support.
>   * i40evf support.
>
> Thanks to Alex, Daniel, John and Scott for all feedback!
>
> v7:
>   * Proper MTU check for XDP
>
> v6:
>   * Addressed various cosmetic issues (reverse xmas tree formatting on
>     local variables, preserve function parameter ordering, qvector
>     mapping).
>   * Placed XDP Tx rings directly after Tx rings. This opened up to
>     various simplications in the code, since we can now treat the XDP
>     Tx rings as an extension of existing Tx ring space. E.g.,
>     i40e_set_ringparam now has smaller changeset.
>   * Ring allocation and setup was simplified (i40e_alloc_rings,
>     i40e_vsi_alloc_arrays).
>
> v5:
>   * Aligned the implementation to ixgbe's XDP support: naming, favor
>     xchg instead of RCU semantics
>   * Support for XDP headroom (piggybacking on Alex' build_skb work)
>   * Added xdp tracepoints for exception states (as suggested by
>     Daniel)
>
> v4:
>   * Removed unused i40e_page_is_reserved function
>   * Prior running the XDP program, set the struct xdp_buff
>     data_hard_start member
>
> v3:
>   * Rebased patch set on Jeff's dev-queue branch
>   * MSI-X is no longer a prerequisite for XDP
>   * RCU locking for the XDP program and XDP_RX support is introduced
>     in the same patch
>   * Rx bytes is now bumped for XDP
>   * Removed pointer-to-pointer clunkiness
>   * Added comments to XDP preconditions in ndo_xdp
>   * When a non-EOF is received, log once, and drop the frame
>
> v2:
>   * Fixed kbuild error for PAGE_SIZE >= 8192.
>   * Renamed i40e_try_flip_rx_page to i40e_can_reuse_rx_page, which is
>     more in line to the other Intel Ethernet drivers (igb/fm10k).
>   * Validate xdp_adjust_head support in ndo_xdp/XDP_SETUP_PROG.
>
> Bj?rn T?pel (2):
>   i40e: add XDP support for pass and drop actions
>   i40e: add support for XDP_TX action
>
>  drivers/net/ethernet/intel/i40e/i40e.h         |   8 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  42 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 364 ++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 244 ++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  12 +
>  5 files changed, 565 insertions(+), 105 deletions(-)
>
> --
> 2.11.0
>
