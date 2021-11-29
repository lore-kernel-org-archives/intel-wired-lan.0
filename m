From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 29 Nov 2021 11:22:54 -0800
Subject: [Intel-wired-lan] [PATCH net-next 0/6] iavf: Add support for
 VIRTCHNL_VF_OFFLOAD_VLAN_V2
Message-ID: <20211129192300.14188-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

This patch series adds support in the iavf driver for communicating and
using VIRTCHNL_VF_OFFLOAD_VLAN_V2. The current VIRTCHNL_VF_OFFLOAD_VLAN
is very limited and covers all 802.1Q VLAN offloads and filtering with
no granularity.

The new VIRTCHNL_VF_OFFLOAD_VLAN_V2 adds more granularity, flexibility,
and support for 802.1ad offloads and filtering. This includes the VF
negotiating which VLAN offloads/filtering it's allowed, where VLAN tags
should be inserted and/or stripped into and from descriptors, and the
supported VLAN protocols.

Brett Creeley (6):
  virtchnl: Add support for new VLAN capabilities
  iavf: Add support for VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation
  iavf: Add support VIRTCHNL_VF_OFFLOAD_VLAN_V2 during netdev config
  iavf: Add support for VIRTCHNL_VF_OFFLOAD_VLAN_V2 hotpath
  iavf: Add support for VIRTCHNL_VF_OFFLOAD_VLAN_V2 offload
    enable/disable
  iavf: Restrict maximum VLAN filters for VIRTCHNL_VF_OFFLOAD_VLAN_V2

 drivers/net/ethernet/intel/iavf/iavf.h        |  45 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 767 +++++++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  72 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  30 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 534 ++++++++++--
 include/linux/avf/virtchnl.h                  | 378 +++++++++
 6 files changed, 1609 insertions(+), 217 deletions(-)

-- 
2.20.1

