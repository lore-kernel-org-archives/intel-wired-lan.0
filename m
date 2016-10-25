From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:17:54 -0700
Subject: [Intel-wired-lan] [next PATCH S51 0/9] i40e/i40evf updates
Message-ID: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck adds code to be much more verbose about what we can and 
cannot offload.

Jacob Keller removes unnecessary label from
i40e_vc_config_promiscuous_mode_msg, removes second check of VLAN_N_VID
in i40e_vlan_rx_add_vid, adds code to avoid duplicate private flags
definitions & fixes trivial typo in naming of i40e_sync_filters_subtask.

Matt Jared adds code to fix compile error due to type conflict.

Michal Kosiarz adds Clause22 implementation.

Piotr Raczynski adds protocols over MCTP to i40e_aq_discover_capabilities.

 drivers/net/ethernet/intel/i40e/i40e_common.c      | 188 ++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  42 ++---
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  60 +++++--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  23 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   7 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   4 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  59 +++++++
 8 files changed, 303 insertions(+), 92 deletions(-)

-- 
2.4.11

