From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:10 -0700
Subject: [Intel-wired-lan] [PATCH v1 00/18] fm10k reset + suspend/resume
	changes
Message-ID: <20160603224228.10192-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series implements several fixes for suspend/resume and related
behaviors for both PF and VF driver. The major changes are to commonize
the suspend/resume, io_error_detected, reset_notify and reinit flows to
use one set of functions. This ensures that all flows set the same
state, preventing multiple flows from interacting together. In addition
it ensures that each flow does every step that it needs. This was
previously overlooked because each flow was coded separately.

In addition, there are several bug fixes scattered around the series for
issues that came up when testing the changes and the bugs that these
changes fix.

Jacob Keller (17):
  fm10k: no need to continue in fm10k_down if __FM10K_DOWN already set
  fm10k: avoid possible null pointer dereference in fm10k_update_stats
  fm10k: prevent multiple threads updating statistics
  fm10k: don't stop reset due to FM10K_ERR_REQUESTS_PENDING
  fm10k: perform data path reset even when switch is not ready
  fm10k: use actual hardware registers when checking for pending Tx
  fm10k: only warn when stop_hw fails with FM10K_ERR_REQUESTS_PENDING
  fm10k: wait for queues to drain fully before stop_hw
  fm10k: split fm10k_reinit into two functions
  fm10k: implement prepare_suspend and handle_resume
  fm10k: use common reset flow when handling io errors from PCI stack
  fm10k: implement reset_notify handler for PCIe FLR events
  fm10k: use common flow for suspend and resume
  fm10k: enable bus master after every reset
  fm10k: check if PCIe link is restored
  fm10k: implement request_lport_map pointer
  fm10k: bump version number

Ngai-Mint Kwan (1):
  fm10k: Reset mailbox global interrupts

 drivers/net/ethernet/intel/fm10k/fm10k.h         |   2 +
 drivers/net/ethernet/intel/fm10k/fm10k_common.c  |   6 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |   2 +
 drivers/net/ethernet/intel/fm10k/fm10k_main.c    |  12 +-
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.h     |   2 +
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 311 +++++++++++++----------
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c      |  38 ++-
 drivers/net/ethernet/intel/fm10k/fm10k_type.h    |   2 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c      |  12 +-
 9 files changed, 222 insertions(+), 165 deletions(-)

-- 
2.8.2.820.gd1c5f70

