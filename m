From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:35:57 -0700
Subject: [Intel-wired-lan] [next PATCH S52 00/11] i40e/i40evf updates
Message-ID: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alan Brady checks for msix_entries null dereference.

Carolyn Wyborny adds 25G PHY_TYPE capability defines, 
adds FEC for 25g, adds fix for new bits set and sizing 
for 25G support.

Eric Joyner adds code to preserve extended PHY type 
field in i40e_set_fc().

Henry Tieman removes unreachable code and adds code 
to pass unknown PHY type for unknown PHYs.

Jacob Keller adds code to protect against NULL 
msix_entries and q_vectors pointers.

Michal Kosiarz adds support for 25G and adds media 
type detection for 25G link.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 40 +++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 23 ++++---
 drivers/net/ethernet/intel/i40e/i40e_devids.h      |  2 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 20 +++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        | 71 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  3 +
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 40 +++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  2 +
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |  2 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h      | 71 +++++++++++-----------
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  8 +++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 26 ++++++--
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  3 +
 14 files changed, 221 insertions(+), 94 deletions(-)

-- 
2.4.11

