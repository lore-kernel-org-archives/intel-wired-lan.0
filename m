From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:40 -0400
Subject: [Intel-wired-lan] [next PATCH S14 00/15] i40e/i40evf updates
Message-ID: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Carolyn marks a parameter __always_unused, adds info to nvm info struct
for OEM version data, and updates fw version text string per previous
product formats.

Catherine adds module_types and update_link_info and refactors PHY structure
and add phy_capabilities enum.

Greg B. converts CEE App TLV selector to IEEE selector.

Greg R. adds promiscuous on VLAN support.

Mitch properly handles ndo_set_mac_address call, removes a redundant call,
tells the pf not to panic on VSI allocation failure, and the vf not to blow
away MAC addresses.

Neerav uses the BIT() macro for priority map parsing.

Shannon adds new link status defines and splits device ids into a separate
file.

 drivers/net/ethernet/intel/i40e/i40e.h             |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  98 +++++++++-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |  18 +-
 drivers/net/ethernet/intel/i40e/i40e_devids.h      |  55 ++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 205 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  22 ++-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   7 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  86 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  13 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |  55 ++++++
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |  83 ++++++---
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  20 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   2 +
 17 files changed, 518 insertions(+), 174 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_devids.h
 create mode 100644 drivers/net/ethernet/intel/i40evf/i40e_devids.h

-- 
1.9.3

