From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:40 -0800
Subject: [Intel-wired-lan] [next PATCH S25 00/16] i40e/i40evf updates
Message-ID: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain adds some fixes to write-back-on-itr to work 
with legacy itr.

Jesse Brandeburg refactors a dcb function, removes VF device IDs 
from PF, and also removes an unnecessary local variable.

Mitch Williams adds counter for arq overflows, add 20G speed for 
tx bandwidth calculations, and enables bus master after reset.

Pandi Maharajan stores lan_vsi_idx and lan_vsi_id in the right size.

Shannon Nelson implements 'AQ Shared resource flags',
'AQ Add set_switch_config', 'AQ Add VXLAN-GPE tunnel type',
and 'AQ thermal sensor control struct'. Also bumps AQ minor 
version to 1.5 for new FW features, adds a little more to an 
NVM update debug message, and finally adds netdev info to vsi dump.

 drivers/net/ethernet/intel/i40e/i40e.h             |  1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 49 ++++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  8 ----
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         | 15 +++++--
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 24 +++++++----
 drivers/net/ethernet/intel/i40e/i40e_devids.h      |  4 --
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  5 +++
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  5 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 18 +++++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  3 ++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  4 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 49 ++++++++++++++++++++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  3 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  1 +
 15 files changed, 152 insertions(+), 41 deletions(-)

-- 
2.1.0

