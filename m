From: Haiyue Wang <haiyue.wang@intel.com>
Date: Tue,  6 Apr 2021 09:00:19 +0800
Subject: [Intel-wired-lan] [PATCH net-next v1 0/6] Enable Intel VF RSS
Message-ID: <20210406010025.90549-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Current Intel VF (iAVF) doesn't supoort RSS hash by ethtool, the users
need to use the PF interface to configure the RSS hash.

For making the VF configure the RSS hash by itself, define new virtchnl
messages, so that VF can query the PF support to do RSS hash by ethtool
commands.

Haiyue Wang (4):
  iavf: Add framework to enable ethtool RSS config
  iavf: Support ethtool TCP flow RSS hash
  iavf: Support ethtool UDP flow RSS hash
  iavf: Support ethtool SCTP flow RSS hash

Qi Zhang (2):
  ice: Enable RSS configure for AVF
  ice: Support RSS configure removal for AVF

 drivers/net/ethernet/intel/iavf/Makefile      |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  10 +
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    | 224 +++++++++
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |  96 ++++
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 253 +++++++++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  28 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 166 +++++++
 drivers/net/ethernet/intel/ice/ice_flow.c     |  88 ++++
 drivers/net/ethernet/intel/ice/ice_flow.h     |   6 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 465 ++++++++++++++++++
 include/linux/avf/virtchnl.h                  |  25 +-
 12 files changed, 1365 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_adv_rss.h

-- 
2.31.1

