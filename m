From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:46 -0800
Subject: [Intel-wired-lan] [PATCH S17 00/17] Implementation updates for ice
Message-ID: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin (2):
  ice: Return configuration error without queue to disable
  ice: Fix issue when adding more than allowed VLANs

Anirudh Venkataramanan (1):
  ice: Create framework for VSI queue context

Brett Creeley (8):
  ice: Calculate ITR increment based on direct calculation
  ice: Reduce scope of variable in ice_vsi_cfg_rxqs
  ice: Use ice_for_each_q_vector macro where possible
  ice: Add ability to update rx-usecs-high
  ice: Remove unnecessary wait when disabling/enabling Rx queues
  ice: Add reg_idx variable in ice_q_vector structure
  ice: Refactor link event flow
  ice: Use dev_err when ice_cfg_vsi_lan fails

Bruce Allan (1):
  ice: Resolve static analysis reported issue

Jesse Brandeburg (1):
  ice: Use pf instead of vsi-back

Maciej Fijalkowski (1):
  ice: Validate ring existence and its q_vector per VSI

Md Fahad Iqbal Polash (1):
  ice: Remove runtime change of PFINT_OICR_ENA register

Paul Greenwalt (1):
  ice: Add 52 byte RSS hash key support

Tony Nguyen (1):
  ice: Add missing PHY type to link settings

 drivers/net/ethernet/intel/ice/ice.h             |  23 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |   3 +
 drivers/net/ethernet/intel/ice/ice_common.c      |  91 +++++--
 drivers/net/ethernet/intel/ice/ice_common.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |  32 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c         | 308 ++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_lib.h         |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c        | 129 +++++-----
 drivers/net/ethernet/intel/ice/ice_sched.c       |  54 +++-
 drivers/net/ethernet/intel/ice/ice_switch.c      |  22 ++
 drivers/net/ethernet/intel/ice/ice_switch.h      |   9 +
 drivers/net/ethernet/intel/ice/ice_txrx.c        | 137 +++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  30 +--
 14 files changed, 541 insertions(+), 310 deletions(-)

-- 
2.14.5

