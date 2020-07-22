From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 21 Jul 2020 18:27:09 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 0/7] udp_tunnel: convert Intel
 drivers with shared tables
Message-ID: <20200722012716.2814777-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This set converts Intel drivers which have the ability to spawn
multiple netdevs, but have only one UDP tunnel port table.

Appropriate support is added to the core infra in patch 1,
followed by netdevsim support and a selftest.

The table sharing works by core attaching the same table
structure to all devices sharing the table. This means the
reference count has to accommodate potentially large values.

Once core is ready i40e and ice are converted. These are
complex drivers, and I don't have HW to test so please
review..

Jakub Kicinski (7):
  udp_tunnel: add the ability to share port tables
  netdevsim: add warnings on unexpected UDP tunnel port errors
  netdevsim: shared UDP tunnel port table support
  selftests: net: add a test for shared UDP tunnel info tables
  i40e: convert to new udp_tunnel infrastructure
  ice: remove unused args from ice_get_open_tunnel_port()
  ice: convert to new udp_tunnel infrastructure

 drivers/net/ethernet/intel/i40e/i40e.h        |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 264 ++++--------------
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c     |   2 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 231 +++++++--------
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |  11 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  97 ++-----
 drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
 drivers/net/netdevsim/netdevsim.h             |   7 +-
 drivers/net/netdevsim/udp_tunnels.c           |  30 +-
 include/net/udp_tunnel.h                      |  24 ++
 net/ipv4/udp_tunnel_nic.c                     |  96 ++++++-
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 109 ++++++++
 14 files changed, 440 insertions(+), 451 deletions(-)

-- 
2.26.2

