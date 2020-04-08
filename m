From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 08 Apr 2020 13:50:34 +0200
Subject: [Intel-wired-lan] [PATCH RFC v2 00/33] XDP extend with knowledge of
 frame size
Message-ID: <158634658714.707275.7903484085370879864.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

RFC-note: This is only an RFC because net-next is closed.
- Please ACK patches you like, then I will collect those for later.

XDP have evolved to support several frame sizes, but xdp_buff was not
updated with this information. This have caused the side-effect that
XDP frame data hard end is unknown. This have limited the BPF-helper
bpf_xdp_adjust_tail to only shrink the packet. This patchset address
this and add packet tail extend/grow.

The purpose of the patchset is ALSO to reserve a memory area that can be
used for storing extra information, specifically for extending XDP with
multi-buffer support. One proposal is to use same layout as
skb_shared_info, which is why this area is currently 320 bytes.

When converting xdp_frame to SKB (veth and cpumap), the full tailroom
area can now be used and SKB truesize is now correct. For most
drivers this result in a much larger tailroom in SKB "head" data
area. The network stack can now take advantage of this when doing SKB
coalescing. Thus, a good driver test is to use xdp_redirect_cpu from
samples/bpf/ and do some TCP stream testing.

---

Ilias Apalodimas (1):
      net: netsec: Add support for XDP frame size

Jesper Dangaard Brouer (32):
      xdp: add frame size to xdp_buff
      bnxt: add XDP frame size to driver
      sfc: add XDP frame size
      mvneta: add XDP frame size to driver
      net: XDP-generic determining XDP frame size
      xdp: xdp_frame add member frame_sz and handle in convert_to_xdp_frame
      xdp: cpumap redirect use frame_sz and increase skb_tailroom
      veth: adjust hard_start offset on redirect XDP frames
      veth: xdp using frame_sz in veth driver
      dpaa2-eth: add XDP frame size
      hv_netvsc: add XDP frame size to driver
      qlogic/qede: add XDP frame size to driver
      net: ethernet: ti: add XDP frame size to driver cpsw
      ena: add XDP frame size to amazon NIC driver
      mlx4: add XDP frame size and adjust max XDP MTU
      mlx5: rx queue setup time determine frame_sz for XDP
      net: thunderx: add XDP frame size
      nfp: add XDP frame size to netronome driver
      tun: add XDP frame size
      vhost_net: also populate XDP frame size
      virtio_net: add XDP frame size in two code paths
      ixgbe: fix XDP redirect on archs with PAGE_SIZE above 4K
      ixgbe: add XDP frame size to driver
      ixgbevf: add XDP frame size to VF driver
      i40e: add XDP frame size to driver
      ice: add XDP frame size to driver
      xdp: for Intel AF_XDP drivers add XDP frame_sz
      xdp: allow bpf_xdp_adjust_tail() to grow packet size
      xdp: clear grow memory in bpf_xdp_adjust_tail()
      bpf: add xdp.frame_sz in bpf_prog_test_run_xdp().
      selftests/bpf: adjust BPF selftest for xdp_adjust_tail
      selftests/bpf: xdp_adjust_tail add grow tail tests


 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    1 
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |    5 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    1 
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |    1 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |    1 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   31 ++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |    2 
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   34 ++++--
 drivers/net/ethernet/intel/ice/ice_xsk.c           |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   33 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |    2 
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   34 ++++--
 drivers/net/ethernet/marvell/mvneta.c              |   25 ++--
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |    3 
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    4 +
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    1 
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |    1 
 drivers/net/ethernet/qlogic/qede/qede_main.c       |    2 
 drivers/net/ethernet/sfc/rx.c                      |    1 
 drivers/net/ethernet/socionext/netsec.c            |   30 +++--
 drivers/net/ethernet/ti/cpsw.c                     |    1 
 drivers/net/ethernet/ti/cpsw_new.c                 |    1 
 drivers/net/hyperv/netvsc_bpf.c                    |    1 
 drivers/net/hyperv/netvsc_drv.c                    |    2 
 drivers/net/tun.c                                  |    2 
 drivers/net/veth.c                                 |   28 +++--
 drivers/net/virtio_net.c                           |   15 ++
 drivers/vhost/net.c                                |    1 
 include/net/xdp.h                                  |   31 +++++
 include/net/xdp_sock.h                             |   11 ++
 include/uapi/linux/bpf.h                           |    4 -
 kernel/bpf/cpumap.c                                |   21 ---
 net/bpf/test_run.c                                 |   16 ++-
 net/core/dev.c                                     |   14 +-
 net/core/filter.c                                  |   23 +++-
 net/core/xdp.c                                     |    7 +
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |  123 +++++++++++++++++++-
 .../testing/selftests/bpf/progs/test_adjust_tail.c |   30 -----
 .../bpf/progs/test_xdp_adjust_tail_grow.c          |   33 +++++
 .../bpf/progs/test_xdp_adjust_tail_shrink.c        |   30 +++++
 43 files changed, 472 insertions(+), 139 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_adjust_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c

--

