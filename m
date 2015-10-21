From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:01 -0400
Subject: [Intel-wired-lan] [next PATCH S19 00/15] i40e/i40evf updates
Message-ID: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali adds a workaround fix for mss < 256 issue and adds a stat to track
how many times we have to do a force WB.

Catherine moves the saving of old link info from handle_link_event to
link_event.

Helin properly cast type for arithmetic, adds a comment to #endif, returns
the number of enabled queues for ETHTOOL_GRXRINGS, reworks the functions
to configure RSS with similar parameters, and creates a generic configure rss
function.

Mitch cleans up error messages, and adds support to handle many MAC filters
correctly.

Shannon removes an unused tunnel parameter, changes BUG_ON to WARN_ON in
service event complete, removes BUG_ON from feature string building,
and removes BUG_ON from fcoe setup

 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  76 +++---
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   2 -
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 255 ++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  15 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  21 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |   2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  12 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   1 +
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  58 ++++-
 13 files changed, 311 insertions(+), 140 deletions(-)

-- 
1.9.3

