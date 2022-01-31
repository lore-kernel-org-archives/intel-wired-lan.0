From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Mon, 31 Jan 2022 10:59:18 -0600
Subject: [Intel-wired-lan] [PATCH for-next 0/3] Add DSCP QoS mappings for
 RDMA
Message-ID: <20220131165921.1392-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series adds support for using DSCP QoS mappings for RDMA on Intel
Ethernet 800 Series devices.

One the series is reviewed, a shared PR will be created from intel-next
for Patch #1.

Dave Ertman (1):
  net/ice: add support for DSCP QoS for IIDC

Mustafa Ismail (2):
  RDMA/irdma: Refactor DCB bits in prep for DSCP support
  RDMA/irdma: Add support for DSCP

 drivers/infiniband/hw/irdma/cm.c         | 24 +++++++++++++++-----
 drivers/infiniband/hw/irdma/cm.h         |  7 ++++++
 drivers/infiniband/hw/irdma/ctrl.c       | 39 ++++++++++++++++++++++----------
 drivers/infiniband/hw/irdma/i40iw_if.c   |  2 +-
 drivers/infiniband/hw/irdma/main.c       | 10 +++++++-
 drivers/infiniband/hw/irdma/main.h       |  2 +-
 drivers/infiniband/hw/irdma/osdep.h      |  1 +
 drivers/infiniband/hw/irdma/type.h       |  4 ++++
 drivers/infiniband/hw/irdma/verbs.c      |  4 ++--
 drivers/net/ethernet/intel/ice/ice_idc.c |  5 ++++
 include/linux/net/intel/iidc.h           |  6 +++++
 11 files changed, 81 insertions(+), 23 deletions(-)

-- 
1.8.3.1

