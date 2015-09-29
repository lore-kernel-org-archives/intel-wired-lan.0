From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 29 Sep 2015 15:19:37 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] use napi_schedule_irqoff()
Message-ID: <20150929215117.3388.48642.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is meant to replace the calls to napi_schedule with
napi_schedule_irqoff as this should help to reduce the interrupt overhead
slightly by removing the unneeded call to local_irq_save and
local_irq_restore.

---

Alexander Duyck (3):
      ixgbe/ixgbevf: use napi_schedule_irqoff()
      i40e/i40evf: use napi_schedule_irqoff()
      fm10k: use napi_schedule_irqoff()


 drivers/net/ethernet/intel/fm10k/fm10k_pci.c      |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       |    6 ++++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c   |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    4 ++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 +-
 5 files changed, 9 insertions(+), 7 deletions(-)

--
