From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 31 Jan 2019 13:57:15 -0800
Subject: [Intel-wired-lan] [STABLE 0/4] ice driver backports for 4.19 stable
Message-ID: <20190131215719.8272-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains backports for the ice driver. These backports are
required as the ice driver in the 4.19 stable tree currently fails to load.
This is because of mismatches between the driver code and the latest
firmware running on the devices.

With these patches, the ice driver can load and pass traffic.

Anirudh Venkataramanan (4):
  ice: Update expected FW version
  ice: Updates to Tx scheduler code
  ice: Introduce ice_dev_onetime_setup
  ice: Set timeout when disabling queues

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  24 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_controlq.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_sched.c    | 161 ++++++------------
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 7 files changed, 83 insertions(+), 117 deletions(-)

-- 
2.17.2

