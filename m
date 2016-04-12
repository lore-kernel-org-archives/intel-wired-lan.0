From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Tue, 12 Apr 2016 08:30:39 -0700
Subject: [Intel-wired-lan] [next PATCH S33 00/13] i40e/i40evf updates
Message-ID: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain, with Greg Rose as co-author adds driver support for promiscuous mode.

Greg Rose removes zero check for rule ID and adds support for promiscuous mode 
in VLAN.

Jesse Brandeburg ensures vlan tag is offlloaded only if enabled.

Kamil Krawczyk adds DeviceID for X722 QSFP+.

Kiran Patil allows user to change input set mask for flow director.

Michal Kosiarz adds device capability which defines if update is available.

Mitch Williams adds support for configuring VF RSS, checks that vsi_res pointer 
is valid before dereferencing it and allows PF driver to configure RSS.

Shannon Nelson cleans up code in preparation for future cloud work and specifies 
AQ event opcode to wait for.

 drivers/net/ethernet/intel/i40e/i40e.h             |   7 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  82 ++++-
 drivers/net/ethernet/intel/i40e/i40e_devids.h      |   1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 128 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  35 ++-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  49 ++-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   8 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   6 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 346 ++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   2 +
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   3 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   6 +
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  39 ++-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 121 ++++---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 327 +++++++------------
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 130 ++++++++
 21 files changed, 976 insertions(+), 323 deletions(-)

-- 
2.4.3

