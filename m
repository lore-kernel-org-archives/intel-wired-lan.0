From: Qi Zhang <qi.z.zhang@intel.com>
Date: Wed,  8 Jul 2020 10:49:50 +0800
Subject: [Intel-wired-lan] [PATCH S48 v4 00/16] Support Advanced AVF features
Message-ID: <20200708025006.44071-1-qi.z.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The patchset add the backend code for below new advanced AVF features:
1. Flexible Description selection to offload metadata
2. FDIR filter rule adding / deleting.
3. Per flow configurable inputset RSS
besides support regular l3/l4 5 tuple inputset for FDIR and RSS, the
patchset
added more protocol support which include GTP-U, L2TPv3, PFCF, ESP,
AH...

v4:
- fix coding style by removing unnecessary code wrap.
- decouple PATCH v2 10/14 that enable FDIR for VF into 3 patches:
  1) PATCH 10/16 focus on virtual channel message handle.
  2) PATCH 11/16 focus on pattern action parser.
  3) Enable new FDIR actions that only support VF.

v3:
- fix couple coding style issue and typo
- use devm alloc/free for cross function memory
- squash patch 11/16 , 12/16 into 10/16.

v2:
- fix typo in commit log.

Qi Zhang (16):
  ice: Enable flexible descriptor RXDID querying and configuration
  ice: Add more basic protocol support for flow filter
  ice: Support non word aligned input set field
  ice: Add more advanced protocol support in flow filter
  ice: Support to separate GTP-U uplink and downlink
  ice: Enhanced IPV4 and IPV6 flow filter
  ice: Enable RSS Configure for AVF
  ice: Support RSS configure removal for AVF
  ice: Add support for per VF ctrl VSI enabling
  ice: Support FDIR configure for AVF
  ice: Add FDIR pattern action arser for VF
  ice: Add new actions support for VF FDIR
  ice: Add non-IP Layer2 protocol FDIR filter for AVF
  ice: Add GTPU FDIR filter for AVF
  ice: Add more FDIR filter type for AVF
  ice: Check FDIR program status for AVF

 drivers/net/ethernet/intel/ice/Makefile            |    2 +-
 drivers/net/ethernet/intel/ice/ice.h               |    6 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |    4 +
 drivers/net/ethernet/intel/ice/ice_fdir.c          |   29 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h          |   39 +
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |  521 ++++-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |    3 +-
 drivers/net/ethernet/intel/ice/ice_flex_type.h     |   78 +
 drivers/net/ethernet/intel/ice/ice_flow.c          |  885 +++++++-
 drivers/net/ethernet/intel/ice/ice_flow.h          |  168 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |   22 +
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |   22 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   64 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   11 +-
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |   10 +
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    5 +
 drivers/net/ethernet/intel/ice/ice_type.h          |   18 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 2208 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h |   49 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c   |  655 +++++-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h   |   11 +
 include/linux/avf/virtchnl.h                       |  324 ++-
 22 files changed, 5050 insertions(+), 84 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h

-- 
2.13.6

