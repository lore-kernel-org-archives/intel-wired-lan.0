From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:04 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 00/15] i40e/i40evf updates
Message-ID: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Alan Brady adds check for msix_entries null dereference.

Alexander Duyck fixes napi_poll function to return the actual the 
work done.

Bimmy Pujari changes version from 1.6.21 to 1.6.25.

Carolyn Wyborny adds code for change message to only appear when 
extra debug info is wanted.

Filip Sadowski adds code to make driver prints log message on link 
speed change.

Harshitha Ramamurthy adds fix for ethtool Supported link modes.

Henry Tieman removes unreachable code, adds code to pass unknown 
PHY type for unknown PHYs and adds code to link LED on 1G BaseT 
boards.

Jacob Keller adds code to protect against NULL msix_entries and 
q_vectors pointers, sets broadcast promiscuous mode for each active 
VLAN, replaces memcpy with single memcpy call in ethtool, restores 
workaround for removing default MAC filter and removes code to handle 
dev_addr specially.

Mitch Williams adds code to simplify txd use count calculation.

 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  46 ++++-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  50 +++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 207 ++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  45 +++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   7 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  45 +++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  28 ++-
 11 files changed, 296 insertions(+), 143 deletions(-)

-- 
2.4.11

