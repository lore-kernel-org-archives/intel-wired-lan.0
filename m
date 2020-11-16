From: alardam@gmail.com <alardam@gmail.com>
Date: Mon, 16 Nov 2020 10:34:44 +0100
Subject: [Intel-wired-lan] [PATCH 0/8] New netdev feature flags for XDP
Message-ID: <20201116093452.7541-1-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Implement support for checking if a netdev has native XDP and AF_XDP zero
copy support. Previously, there was no way to do this other than to try
to create an AF_XDP socket on the interface or load an XDP program and
see if it worked. This commit changes this by extending existing
netdev_features in the following way:
 * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRECT})
 * af-xdp-zc  - AF_XDP zero copy support
NICs supporting these features are updated by turning the corresponding
netdev feature flags on.

NOTE:
 Only the compilation check was performed for:
  - ice, 
  - igb,
  - mlx5, 
  - bnxt, 
  - dpaa2, 
  - mvmeta, 
  - mvpp2, 
  - qede,
  - sfc, 
  - netsec, 
  - cpsw, 
  - xen, 
  - virtio_net.

Libbpf library is extended in order to provide a simple API for gathering
information about XDP supported capabilities of a netdev. This API
utilizes netlink interface towards kernel. With this function it is
possible to get xsk supported options for netdev beforehand.
The new API is used in core xsk code as well as in the xdpsock sample.

These new flags also solve the problem with strict recognition of zero
copy support. The problem is that there are drivers out there that only
support XDP partially, so it is possible to successfully load the XDP
program in native mode, but it will still not be able to support zero-copy
as it does not have XDP_REDIRECT support. With af-xdp-zc flag the check
is possible and trivial.

Marek Majtyka (8):
  net: ethtool: extend netdev_features flag set
  drivers/net: turn XDP flags on
  xsk: add usage of xdp netdev_features flags
  xsk: add check for full support of XDP in bind
  libbpf: extend netlink attribute API
  libbpf: add functions to get XSK modes
  libbpf: add API to get XSK/XDP caps
  samples/bpf/xdp: apply netdev XDP/XSK modes info

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
 drivers/net/ethernet/intel/igb/igb_main.c     |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   3 +
 drivers/net/ethernet/marvell/mvneta.c         |   1 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +
 drivers/net/ethernet/qlogic/qede/qede_main.c  |   1 +
 drivers/net/ethernet/sfc/efx.c                |   1 +
 drivers/net/ethernet/socionext/netsec.c       |   1 +
 drivers/net/ethernet/ti/cpsw.c                |   2 +
 drivers/net/ethernet/ti/cpsw_new.c            |   2 +
 drivers/net/tun.c                             |   4 +
 drivers/net/veth.c                            |   1 +
 drivers/net/virtio_net.c                      |   1 +
 drivers/net/xen-netfront.c                    |   1 +
 include/linux/netdev_features.h               |   6 +
 include/net/xdp.h                             |  13 +
 include/net/xdp_sock_drv.h                    |  11 +
 include/uapi/linux/if_xdp.h                   |   1 +
 net/ethtool/common.c                          |   2 +
 net/xdp/xsk.c                                 |   4 +-
 net/xdp/xsk_buff_pool.c                       |  21 +-
 samples/bpf/xdpsock_user.c                    | 117 +++++-
 tools/include/uapi/linux/ethtool.h            |  44 ++
 tools/include/uapi/linux/if_xdp.h             |   1 +
 tools/lib/bpf/ethtool.h                       |  49 +++
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/netlink.c                       | 379 +++++++++++++++++-
 tools/lib/bpf/nlattr.c                        | 105 +++++
 tools/lib/bpf/nlattr.h                        |  22 +
 tools/lib/bpf/xsk.c                           |  54 ++-
 tools/lib/bpf/xsk.h                           |   3 +-
 36 files changed, 845 insertions(+), 20 deletions(-)
 create mode 100644 tools/lib/bpf/ethtool.h

-- 
2.20.1

