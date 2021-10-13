From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Wed, 13 Oct 2021 11:22:38 -0500
Subject: [Intel-wired-lan] [net-next 0/3] Configure iWARP or RoCEv2 protocol
 support for E800 devices
Message-ID: <20211013162241.689-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently E800 devices come up as RoCEv2 devices by default.

This series add supports for users to configure iWARP or RoCEv2 functionality
per PCI function. devlink parameters is used to realize this and is keyed
off similar work in [1].

[1] https://lore.kernel.org/linux-rdma/20210810132424.9129-1-parav at nvidia.com/

Shiraz Saleem (3):
  devlink: Add 'enable_iwarp' generic device param
  net/ice: Add support for enable_iwarp and enable_roce devlink param
  RDMA/irdma: Set protocol based on PF rdma_mode flag

 .../networking/devlink/devlink-params.rst          |   3 +
 drivers/infiniband/hw/irdma/main.c                 |   3 +-
 drivers/net/ethernet/intel/ice/ice.h               |   1 +
 drivers/net/ethernet/intel/ice/ice_devlink.c       | 137 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_devlink.h       |   7 +-
 drivers/net/ethernet/intel/ice/ice_idc.c           |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  11 +-
 include/linux/net/intel/iidc.h                     |   7 +-
 include/net/devlink.h                              |   4 +
 net/core/devlink.c                                 |   5 +
 10 files changed, 172 insertions(+), 10 deletions(-)

-- 
1.8.3.1

