From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 May 2017 11:23:07 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 00/14] i40e/i40evf: AVF series
Message-ID: <20170511182321.147850-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is the introduction of the Intel(R) Ethernet Adaptive Virtual
Function driver code and device ID, as presented at the NetDEV 1.2
conference in 2016.
http://netdevconf.org/1.2/session.html?anjali-singhai

The idea is to convert the interface between the i40evf driver
and the parent i40e PF driver to be generic, as the i40evf driver
should in the future be able to run on top of other Intel PF
drivers, and negotiate any features beyond a "base expected" set.

The series appears much bigger than it is due to the "move" of
i40evf_virtchnl.h, which is a really a rename.  Please make sure
your git client shows the rename when doing git log --follow.

Series applies on top of the "i40e/i40evf: small fixes" series,
otherwise there will be conflicts when they are merged.

NOTE: There are some minor checkpatch warnings but I've
reviewed them, and they can be ignored.

v3: updated patch 4 to remove some unnecessary transforms to client
    interface files, also had to update patch 9 to remove unused
    I40E_QUEUE_ defines
v2: updated patch 13,14 with Kconfig changes and added to i40evf.txt,
    other patches were unchanged from v1

Jesse Brandeburg (11):
  i40evf: drop i40e_type.h include
  i40e/i40evf: create and use new unified header file
  i40e: use new unified virtchnl header file
  virtchnl: rename i40e to generic virtchnl
  virtchnl: move some code to core driver
  virtchnl: convert to new macros
  i40e/virtchnl: refactor code for validate checks
  i40evf/virtchnl: whitespace cleanups
  virtchnl: finish conversion to virtchnl interface
  i40e/virtchnl: move function to virtchnl
  i40evf: update i40evf.txt with new content

Preethi Banala (1):
  i40evf: Add support for Adaptive Virtual Function

Sridhar Samudrala (2):
  virtchnl: Add pad fields to a couple of structures
  virtchnl: Add compile time static asserts to validate structure sizes

 Documentation/networking/i40evf.txt                |  23 +-
 MAINTAINERS                                        |   1 +
 drivers/net/ethernet/intel/Kconfig                 |  10 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    | 449 -------------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 474 +++++---------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   9 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  15 +-
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   6 +-
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  | 448 -------------
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  26 +-
 drivers/net/ethernet/intel/i40evf/i40evf_client.c  |  18 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  66 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 285 +++++----
 include/linux/avf/virtchnl.h                       | 701 +++++++++++++++++++++
 19 files changed, 1109 insertions(+), 1435 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
 delete mode 100644 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
 create mode 100644 include/linux/avf/virtchnl.h

-- 
2.9.3

