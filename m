From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 17 Nov 2021 20:26:16 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/6] Devlink cleanups
Message-ID: <cover.1637173517.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series is non-controversial subset of my RFC [1], where I proposed
a way to allow parallel devlink execution.

Thanks

[1] https://lore.kernel.org/all/cover.1636390483.git.leonro at nvidia.com

Leon Romanovsky (6):
  devlink: Remove misleading internal_flags from health reporter dump
  devlink: Delete useless checks of holding devlink lock
  devlink: Simplify devlink resources unregister call
  devlink: Clean registration of devlink port
  devlink: Reshuffle resource registration logic
  devlink: Inline sb related functions

 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   7 +-
 .../freescale/dpaa2/dpaa2-eth-devlink.c       |   7 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  23 +-
 .../marvell/prestera/prestera_devlink.c       |   8 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   4 +-
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |   5 +-
 .../ethernet/mellanox/mlx5/core/en/devlink.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   7 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   9 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  15 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   4 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |   4 +-
 .../net/ethernet/netronome/nfp/nfp_devlink.c  |   4 +-
 .../ethernet/pensando/ionic/ionic_devlink.c   |   8 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  14 +-
 drivers/net/netdevsim/dev.c                   |  11 +-
 include/net/devlink.h                         |   9 +-
 net/core/devlink.c                            | 220 ++++++------------
 net/dsa/dsa.c                                 |   2 +-
 net/dsa/dsa2.c                                |   9 +-
 20 files changed, 115 insertions(+), 257 deletions(-)

-- 
2.33.1

