From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 29 Sep 2021 13:16:34 +0300
Subject: [Intel-wired-lan] [PATCH net-next 0/5] Devlink reload and missed
 notifications fix
Message-ID: <cover.1632909221.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series starts from the fixing the bug introduced by implementing
devlink delayed notifications logic, where I missed some of the
notifications functions.

The rest series provides a way to dynamically set devlink ops that is
needed for mlx5 multiport device and starts cleanup by removing
not-needed logic.

In the next series, we will delete various publish API, drop general
lock, annotate the code and rework logic around devlink->lock.

All this is possible because driver initialization is separated from the
user input now.

Thanks

Leon Romanovsky (5):
  devlink: Add missed notifications iterators
  devlink: Allow modification of devlink ops
  devlink: Allow set specific ops callbacks dynamically
  net/mlx5: Register separate reload devlink ops for multiport device
  devlink: Delete reload enable/disable interface

 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   |   2 +-
 .../freescale/dpaa2/dpaa2-eth-devlink.c       |   2 +-
 .../hisilicon/hns3/hns3pf/hclge_devlink.c     |   5 +-
 .../hisilicon/hns3/hns3vf/hclgevf_devlink.c   |   5 +-
 .../net/ethernet/huawei/hinic/hinic_devlink.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  |   2 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |   2 +-
 .../marvell/prestera/prestera_devlink.c       |   2 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   4 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  15 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   3 -
 .../mellanox/mlx5/core/sf/dev/driver.c        |   5 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  12 +-
 drivers/net/ethernet/mscc/ocelot.h            |   2 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |   2 +-
 .../net/ethernet/netronome/nfp/nfp_devlink.c  |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.h |   2 +-
 .../ethernet/pensando/ionic/ionic_devlink.c   |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   2 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   2 +-
 drivers/net/netdevsim/dev.c                   |   5 +-
 drivers/ptp/ptp_ocp.c                         |   2 +-
 drivers/staging/qlge/qlge_main.c              |   2 +-
 include/net/devlink.h                         |  15 +-
 net/core/devlink.c                            | 155 ++++++++++--------
 net/dsa/dsa2.c                                |   2 +-
 28 files changed, 131 insertions(+), 133 deletions(-)

-- 
2.31.1

