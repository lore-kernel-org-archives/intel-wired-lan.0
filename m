From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Date: Wed,  9 Mar 2022 12:25:44 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 0/2] Add inline flow director
 support for channels
Message-ID: <20220309202546.2332118-1-sudheer.mogilappagari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support to enable inline flow director which allows uniform
distribution of flows among queues of a TC. This is configured
on a per TC basis using devlink interface.

Devlink params are registered/unregistered during TC creation
at runtime. To allow that commit 7a690ad499e7 ("devlink: Clean
not-executed param notifications") needs to be reverted.

Kiran Patil (1):
  ice: Add inline flow director support for channels

Sridhar Samudrala (1):
  devlink: Allow parameter registration/unregistration during runtime

----
v3:
-Updated commit message with symmetric queuing requirement.
-Added related patch to allow dynamic registration of devlink param.
----
 drivers/net/ethernet/intel/ice/ice.h          |  82 +++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 133 ++++++++
 drivers/net/ethernet/intel/ice/ice_devlink.h  |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 173 ++++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 294 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   8 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 net/core/devlink.c                            |  14 +-
 14 files changed, 735 insertions(+), 18 deletions(-)

-- 
2.27.0

