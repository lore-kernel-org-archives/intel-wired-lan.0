From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 20 Sep 2021 12:30:11 -0700
Subject: [Intel-wired-lan] [PATCH net-next v4 0/4] ice: interrupt moderation
 updates
Message-ID: <20210920193014.1148084-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Improve how the driver generates interrupts when it's using DIMLIB, and
repair a couple of bugs found when making this change. It doesn't make
sense for these changes to go into net, because they both depend on
patch one in this series, or changes that are only available in
net-next.

Jesse Brandeburg (3):
  ice: update dim usage and moderation
  ice: fix rate limit update after coalesce change
  ice: fix software generating extra interrupts

 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 ++-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  29 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 119 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 110 +++++++++-------
 6 files changed, 171 insertions(+), 106 deletions(-)
---
v4: addressed comments from list on patch 1/3
v3: fix merge conflicts with ice_ring rename
v2: original version
-- 
2.31.1

