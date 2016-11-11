From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:24 -0800
Subject: [Intel-wired-lan] [next PATCH S54 00/15] i40e/i40evf updates
Message-ID: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Bimmy Pujari deprecates unused macro and i40e_is_mac_710 function.

Jacob Keller defeatures support for PTP L4 frame detection on XL710,
recalculates vsi->active_filters from hash contents, refactors 
i40e_update_filter_state to avoid passing aq_err, factors out 
addition/deletion of VLAN per each MAC address, moves all updates 
for VLAN mode into i40e_sync_vsi_filters, adds code to avoid O(n^2) 
loop when deleting all filters and  adds code to correctly handle 
VLANS, when adding or removing MAC filters.

Mitch Williams removes unused device ID.

 drivers/net/ethernet/intel/i40e/i40e.h             |  27 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  15 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 431 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  21 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   1 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  66 ++--
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   1 -
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   1 -
 8 files changed, 312 insertions(+), 251 deletions(-)

-- 
2.4.11

