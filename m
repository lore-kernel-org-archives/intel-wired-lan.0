From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 26 Oct 2015 19:44:26 -0400
Subject: [Intel-wired-lan] [next PATCH S20 00/15] i40e/i40evf updates
Message-ID: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali fixes the RS bit update in Tx path and disables the force WB
workaround.

Carolyn updates the fw version error messaging.

Helin adds new fields to store user configuraion, renames rss_size to
alloc_rss_size in i40e_pf, renames vf adapter specific rss function, creates
a generic config rss function, creates a generic get rss function, adds new
fields to store user configuration of RSS, and fixes a confusing message.

Jesse adds a prefetch of skb data on transmit.

Mitch makes an  error message more useful, lets the VF give up when it gets
ERR_PARAM from the PF, allocates queue vectors dynamically, and allocates
ring structs dynamically.

 drivers/net/ethernet/intel/i40e/i40e.h             |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  31 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  98 +++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   3 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 123 ++++---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   2 +
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  16 +-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  79 ++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 403 +++++++++++++++------
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  12 +-
 11 files changed, 545 insertions(+), 236 deletions(-)

-- 
1.9.3

