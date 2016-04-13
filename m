From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:20 -0700
Subject: [Intel-wired-lan] [next PATCH S34 00/12] i40e/i40evf updates
Message-ID: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain changes the default for VFs to be not privileged,
limits the number of mac and vlan addresses that can be added for
VFs and prevents fall back to promiscuous mode if the VF is not trusted.

Carolyn Wyborny ensures the VF can not change the RSS hash settings.

Catherine Sullivan fixes an uninitialized variabl and updates a device id for
X722.

Harshitha Ramamurthy bumps i40e/i40evf from 1.5.5 to 1.5.10.

Jesse Brandeburg avoids aggregate return warnings, ensures use of consistent 
type for vf_id and drops an extra copy of a function.

Kiran Patil adds code to keep track of side-band filters based on flow-type.

Neerav Parikh removes HMC AQ API implementation.

 drivers/net/ethernet/intel/i40e/i40e.h             |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   4 -
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  25 ---
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  30 ---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  27 +--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   4 -
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  24 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  64 ++++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   7 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  25 ---
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 201 +--------------------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   2 +-
 14 files changed, 97 insertions(+), 339 deletions(-)

-- 
2.4.3

