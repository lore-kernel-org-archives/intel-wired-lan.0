From: Haiyue Wang <haiyue.wang@intel.com>
Date: Tue, 13 Apr 2021 08:48:38 +0800
Subject: [Intel-wired-lan] [PATCH net-next v3 0/6] Enable Intel VF RSS
Message-ID: <20210413004844.32462-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The current Intel VF (iAVF) doesn't support changing its RSS input
set by ethool. Add support in virtchnl, iavf, and ice to enable
RSS input set changes on the VF via ethtool.

v3: fix the SCTP dest port set wrong.
v2: rewrite the commit message, and some code clean up.

Haiyue Wang (4):
  iavf: Add framework to enable ethtool RSS config
  iavf: Support for modifying TCP RSS flow hashing
  iavf: Support for modifying UDP RSS flow hashing
  iavf: Support for modifying SCTP RSS flow hashing

Qi Zhang (2):
  ice: Enable RSS configure for AVF
  ice: Support RSS configure removal for AVF

 drivers/net/ethernet/intel/iavf/Makefile      |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  10 +
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    | 218 ++++++++
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |  95 ++++
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 252 +++++++++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  27 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 163 ++++++
 drivers/net/ethernet/intel/ice/ice_flow.c     |  88 ++++
 drivers/net/ethernet/intel/ice/ice_flow.h     |   6 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 465 ++++++++++++++++++
 include/linux/avf/virtchnl.h                  |  25 +-
 12 files changed, 1353 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_adv_rss.h

-- 
2.31.1

