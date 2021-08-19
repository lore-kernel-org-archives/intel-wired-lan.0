From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 19 Aug 2021 12:27:38 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 0/3] ice: interrupt moderation
 updates
Message-ID: <20210819192741.590084-1-jesse.brandeburg@intel.com>
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
  ice-linux: update dim usage and moderation
  ice-linux: fix rate limit update after coalesce change
  ice-linux: fix software generating extra interrupts

 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   9 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  29 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 118 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  99 ++++++++-------
 6 files changed, 153 insertions(+), 104 deletions(-)

-- 
2.31.1

