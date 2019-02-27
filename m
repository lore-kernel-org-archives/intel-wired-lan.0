From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 26 Feb 2019 16:35:06 -0800
Subject: [Intel-wired-lan] [PATCH S13 v2 00/17] Bug fixes and minor feature
 updates for ice
Message-ID: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changes in v2:
1. Remove redundant initialization of vsi->idx
2. Remove unimplemented function prototype ice_set_vf_bw
3. Resolve conflicts after dropping set channels patch in the last series

Akeem G Abodunrin (4):
  ice: Fix issue reconfiguring VF queues
  ice: Add support for PF/VF promiscuous mode
  ice: Don't let VF know that it is untrusted
  ice: Get VF VSI instances directly via PF

Alan Brady (1):
  ice: use irq_num var in ice_vsi_req_irq_msix

Anirudh Venkataramanan (2):
  ice: Remove unused function prototype
  ice: Remove unused vsi_id field

Brett Creeley (1):
  ice: Enable link events over the ARQ

Bruce Allan (2):
  ice: fix static analysis warnings
  ice: fix some function prototype and signature style issues

Christopher N Bednarz (1):
  ice: Do not set LB_EN for prune switch rules

Kiran Patil (1):
  ice: fix the divide by zero issue

Michal Swiatkowski (1):
  ice: Restore VLAN switch rule if port VLAN existed before

Victor Raj (2):
  ice: code cleanup in ice_sched.c
  ice: update VSI config dynamically

Yashaswini Raghuram Prathivadi Bhayankaram (2):
  ice: Enable LAN_EN for the right recipes
  ice: Set LAN_EN for all directional rules

 drivers/net/ethernet/intel/ice/ice.h             |  23 +-
 drivers/net/ethernet/intel/ice/ice_common.c      |  65 +++--
 drivers/net/ethernet/intel/ice/ice_common.h      |  24 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_lib.c         |  60 +++-
 drivers/net/ethernet/intel/ice/ice_lib.h         |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c        | 202 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_sched.c       |  94 ++-----
 drivers/net/ethernet/intel/ice/ice_switch.c      | 339 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_switch.h      |  25 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c        |  48 ++--
 drivers/net/ethernet/intel/ice/ice_type.h        |   1 -
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 243 +++++++++++++---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  20 +-
 14 files changed, 920 insertions(+), 251 deletions(-)

-- 
2.14.5

