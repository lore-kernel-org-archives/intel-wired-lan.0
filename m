From: alardam@gmail.com <alardam@gmail.com>
Date: Fri,  4 Dec 2020 11:28:56 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 0/5] New netdev feature flags for
 XDP
Message-ID: <20201204102901.109709-1-marekx.majtyka@intel.com>
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
  - mlx4.
  - bnxt, 
  - dpaa2, 
  - mvmeta, 
  - mvpp2, 
  - qede,
  - sfc, 
  - netsec, 
  - cpsw, 
  - xen, 
  - netronome
  - ena
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

Changes since v1:
 * Replace netdev_feature flags variable with a bitmap of XDP-specific
   properties. New kernel and uapi interfaces are added to handle access
   to the XDP netdev properties bitmap. [Toke]

 * Set more fine grained XPD properties for netdevs when necessary. [Toke]

 * Extend ethtool netlink interface in order to get access to the XDP
   bitmap (XDP_PROPERTIES_GET). [Toke]

 * Removed the libbpf patches for now.
---
Marek Majtyka (5):
  net: ethtool: add xdp properties flag set
  drivers/net: turn XDP properties on
  xsk: add usage of xdp properties flags
  xsk: add check for full support of XDP in bind
  ethtool: provide xdp info with XDP_PROPERTIES_GET

 .../networking/netdev-xdp-properties.rst      | 42 ++++++++
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +
 drivers/net/ethernet/intel/igb/igb_main.c     |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 +
 drivers/net/ethernet/marvell/mvneta.c         |  3 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  3 +
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  2 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +
 .../ethernet/netronome/nfp/nfp_net_common.c   |  5 +
 drivers/net/ethernet/qlogic/qede/qede_main.c  |  2 +
 drivers/net/ethernet/sfc/efx.c                |  2 +
 drivers/net/ethernet/socionext/netsec.c       |  2 +
 drivers/net/ethernet/ti/cpsw.c                |  3 +
 drivers/net/ethernet/ti/cpsw_new.c            |  2 +
 drivers/net/tun.c                             |  4 +
 drivers/net/veth.c                            |  2 +
 drivers/net/virtio_net.c                      |  2 +
 drivers/net/xen-netfront.c                    |  2 +
 include/linux/netdevice.h                     |  2 +
 include/linux/xdp_properties.h                | 53 +++++++++++
 include/net/xdp.h                             | 95 +++++++++++++++++++
 include/net/xdp_sock_drv.h                    | 10 ++
 include/uapi/linux/ethtool.h                  |  1 +
 include/uapi/linux/ethtool_netlink.h          | 14 +++
 include/uapi/linux/if_xdp.h                   |  1 +
 include/uapi/linux/xdp_properties.h           | 32 +++++++
 net/ethtool/Makefile                          |  2 +-
 net/ethtool/common.c                          | 11 +++
 net/ethtool/common.h                          |  4 +
 net/ethtool/netlink.c                         | 38 +++++---
 net/ethtool/netlink.h                         |  2 +
 net/ethtool/strset.c                          |  5 +
 net/ethtool/xdp.c                             | 76 +++++++++++++++
 net/xdp/xsk.c                                 |  4 +-
 net/xdp/xsk_buff_pool.c                       | 20 +++-
 tools/include/uapi/linux/if_xdp.h             |  1 +
 tools/lib/bpf/xsk.c                           |  3 +
 41 files changed, 449 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/networking/netdev-xdp-properties.rst
 create mode 100644 include/linux/xdp_properties.h
 create mode 100644 include/uapi/linux/xdp_properties.h
 create mode 100644 net/ethtool/xdp.c


base-commit: eceae70bdeaeb6b8ceb662983cf663ff352fbc96
-- 
2.27.0

