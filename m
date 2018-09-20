From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:03 -0700
Subject: [Intel-wired-lan] [PATCH 0/8] Minor updates and bug fixes
Message-ID: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anirudh Venkataramanan (2):
  ice: Query the Tx scheduler node before adding it
  ice: Update to capabilities admin queue command

Brett Creeley (1):
  ice: Update comment for ice_fltr_mgmt_list_entry

Bruce Allan (3):
  ice: replace unnecessary memcpy with direct assignment
  ice: update branding strings and supported device ids
  ice: fix changing of ring descriptor size (ethtool -G)

Jacob Keller (2):
  ice: use [sr]q.count when checking if queue is initialized
  ice: update fw version check logic

 drivers/net/ethernet/intel/ice/ice.h            |  4 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  5 ++
 drivers/net/ethernet/intel/ice/ice_common.c     | 50 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_controlq.c   | 40 +++++++++------
 drivers/net/ethernet/intel/ice/ice_devids.h     | 10 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 17 +++++--
 drivers/net/ethernet/intel/ice/ice_main.c       |  2 -
 drivers/net/ethernet/intel/ice/ice_sched.c      | 67 ++++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_switch.h     |  3 +-
 9 files changed, 150 insertions(+), 48 deletions(-)

-- 
2.14.3

