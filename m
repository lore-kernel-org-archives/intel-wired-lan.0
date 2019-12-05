From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Thu, 5 Dec 2019 15:51:11 +0000
Subject: [Intel-wired-lan] [PATCH bpf 0/4] Fix concurrency issues between
 XSK wakeup and control path using RCU
Message-ID: <20191205155028.28854-1-maximmi@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series addresses the issue described in the commit message of the
first patch: lack of synchronization between XSK wakeup and destroying
the resources used by XSK wakeup. The idea is similar to
napi_synchronize. The series contains fixes for the drivers that
implement XSK. I haven't tested the changes to Intel's drivers, so,
Intel guys, please review them.

Maxim Mikityanskiy (4):
  xsk: Add rcu_read_lock around the XSK wakeup
  net/mlx5e: Fix concurrency issues between config flow and XSK
  net/i40e: Fix concurrency issues between config flow and XSK
  net/ixgbe: Fix concurrency issues between config flow and XSK

 drivers/net/ethernet/intel/i40e/i40e_main.c   |  7 ++++--
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  8 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  | 22 ++++++++-----------
 .../mellanox/mlx5/core/en/xsk/setup.c         |  1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 +---------------
 net/xdp/xsk.c                                 |  8 +++++--
 10 files changed, 39 insertions(+), 40 deletions(-)

-- 
2.20.1

