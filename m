From: Alice Michael <alice.michael@intel.com>
Date: Fri, 11 Aug 2017 11:23:52 -0400
Subject: [Intel-wired-lan] [next PATCH S78-V6 00/12] Change Log
Message-ID: <20170811152354.87886-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

V4: Submission to Jeff's tree
V5: Re-ordered patches
V6: Sync with Jeff's latest tree
V7: Changes to patches 1 and 2 as per community feedback

 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |  12 ++
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  55 ++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 231 +++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 154 ++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   7 +
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   9 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  19 ++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  97 +++++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   5 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  55 ++++-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  69 ++++++
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   9 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |  20 ++
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   4 +
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  38 +++-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  97 ++++++++-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  44 +++-
 17 files changed, 846 insertions(+), 79 deletions(-)

-- 
2.9.4

