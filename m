From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:30 -0700
Subject: [Intel-wired-lan] [next PATCH S37 00/15] i40e/i40evf updates
Message-ID: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Avinash Dayanand removes unnecessary code which caused supported link mode bug.

Catherine Sullivan adds a call to set the client interface down and fixes RSS
 to not be limited by the number of CPUs.

Greg Rose adds code to clean up MSIX irqs before suspend and save PCI state
before suspend.

Mitch Williams adds functions to clear default VSI, adds hw struct local
variable, writes HENA for VFs, reports RSS hash capability to stack, , fixes
buffer overflow problem by checking the address count and bailing out of the
loop at the appropriate time, adds code to activate correct MAC address filter
and sets default VSI without a reset

Serey Kong fixes missing DA cable check.

Shannon Nelson adds VSI info to macaddr messages.

Bimmy Pujari bumps version from 1.5.16 to 1.6.4.

 drivers/net/ethernet/intel/i40e/i40e_common.c      |  56 +++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 162 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   2 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   6 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   7 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   8 +
 7 files changed, 175 insertions(+), 70 deletions(-)

-- 
2.4.11

