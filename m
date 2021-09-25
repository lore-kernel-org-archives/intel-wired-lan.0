From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:40 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 00/21] Move devlink_register
 to be last devlink command
Message-ID: <cover.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

This is second version of patch series
https://lore.kernel.org/netdev/cover.1628599239.git.leonro at nvidia.com/

The main change is addition of delayed notification logic that will
allowed us to delete devlink_params_publish API (future series will
remove it completely) and conversion of all drivers to have devlink_register
being last commend.

The series itself is pretty straightforward, except liquidio driver
which performs initializations in various workqueues without proper
locks. That driver doesn't hole device_lock and it is clearly broken
for any parallel driver core flows (modprobe + devlink + PCI reset will
100% crash it).

In order to annotate devlink_register() will lockdep of holding
device_lock, I added workaround in this driver.

Thanks

----------------------
From previous cover letter:
Hi Dave and Jakub,

This series prepares code to remove devlink_reload_enable/_disable API
and in order to do, we move all devlink_register() calls to be right
before devlink_reload_enable().

The best place for such a call should be right before exiting from
the probe().

This is done because devlink_register() opens devlink netlink to the
users and gives them a venue to issue commands before initialization
is finished.

1. Some drivers were aware of such "functionality" and tried to protect
themselves with extra locks, state machines and devlink_reload_enable().
Let's assume that it worked for them, but I'm personally skeptical about
it.

2. Some drivers copied that pattern, but without locks and state
machines. That protected them from reload flows, but not from any _set_
routines.

3. And all other drivers simply didn't understand the implications of early
devlink_register() and can be seen as "broken".

Thanks

Leon Romanovsky (21):
  devlink: Notify users when objects are accessible
  bnxt_en: Register devlink instance at the end devlink configuration
  liquidio: Overcome missing device lock protection in init/remove flows
  dpaa2-eth: Register devlink instance at the end of probe
  net: hinic: Open device for the user access when it is ready
  ice: Open devlink when device is ready
  octeontx2: Move devlink registration to be last devlink command
  net/prestera: Split devlink and traps registrations to separate
    routines
  net/mlx4: Move devlink_register to be the last initialization command
  net/mlx5: Accept devlink user input after driver initialization
    complete
  mlxsw: core: Register devlink instance last
  net: mscc: ocelot: delay devlink registration to the end
  nfp: Move delink_register to be last command
  ionic: Move devlink registration to be last devlink command
  qed: Move devlink registration to be last devlink command
  net: ethernet: ti: Move devlink registration to be last devlink
    command
  netdevsim: Move devlink registration to be last devlink command
  net: wwan: iosm: Move devlink_register to be last devlink command
  ptp: ocp: Move devlink registration to be last devlink command
  staging: qlge: Move devlink registration to be last devlink command
  net: dsa: Move devlink registration to be last devlink command

 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  15 +--
 .../net/ethernet/cavium/liquidio/lio_main.c   |  19 ++--
 .../freescale/dpaa2/dpaa2-eth-devlink.c       |  14 ++-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |   9 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.h  |   5 +-
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  |   7 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  10 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |  15 +--
 .../marvell/prestera/prestera_devlink.c       |  29 +----
 .../marvell/prestera/prestera_devlink.h       |   4 +-
 .../ethernet/marvell/prestera/prestera_main.c |   8 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   8 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 .../mellanox/mlx5/core/sf/dev/driver.c        |   2 +
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  19 +---
 drivers/net/ethernet/mscc/ocelot_vsc7514.c    |   5 +-
 .../ethernet/netronome/nfp/devlink_param.c    |   9 +-
 .../net/ethernet/netronome/nfp/nfp_net_main.c |   5 +-
 .../ethernet/pensando/ionic/ionic_devlink.c   |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   7 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  15 +--
 drivers/net/ethernet/ti/cpsw_new.c            |   7 +-
 drivers/net/netdevsim/dev.c                   |   8 +-
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   7 +-
 drivers/ptp/ptp_ocp.c                         |   6 +-
 drivers/staging/qlge/qlge_main.c              |   8 +-
 net/core/devlink.c                            | 107 +++++++++++++++---
 net/dsa/dsa2.c                                |  10 +-
 30 files changed, 202 insertions(+), 177 deletions(-)

-- 
2.31.1

