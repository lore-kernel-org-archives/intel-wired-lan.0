From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 29 Jun 2020 14:59:38 +0530
Subject: [Intel-wired-lan] [PATCH v1 0/5] ethernet: intel: Convert to
 generic power management
Message-ID: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to remove legacy power management callbacks
from amd ethernet drivers.

The callbacks performing suspend() and resume() operations are still calling
pci_save_state(), pci_set_power_state(), etc. and handling the power management
themselves, which is not recommended.

The conversion requires the removal of the those function calls and change the
callback definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Vaibhav Gupta (5):
  iavf: use generic power management
  igbvf: netdev: use generic power management
  ixgbe: use generic power management
  ixgbevf: use generic power management
  e100: use generic power management

 drivers/net/ethernet/intel/e100.c             | 31 ++++------
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 45 ++++----------
 drivers/net/ethernet/intel/igbvf/netdev.c     | 37 +++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 61 +++++--------------
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 44 +++----------
 5 files changed, 58 insertions(+), 160 deletions(-)

-- 
2.27.0

