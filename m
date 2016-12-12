From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Dec 2016 15:44:06 -0800
Subject: [Intel-wired-lan] [next PATCH S57 00/11] i40e/i40evf updates
Message-ID: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alan Brady adds code to fix disable overflow promiscuous mode and
adds code to refactor AQ CMD buffer debug printing.

Carolyn Wyborny adds code to fix Adaptive ITR enabling.

Harshitha Ramamurthy adds code for error handling for link event.

Joshua Hay adds code to enable mc magic pkt wakeup during power down.

Jacob Keller  removes unnecessary call to i40e_update_link_info, 
converts to cpu from le16 to generate switch_id, adds code to 
properly convert le16 value to CPU format and marks the value passed 
to csum_replace_by_diff as __wsum.

Mitch Williams adds code to free rings in remove function and adds one
comment.

 drivers/net/ethernet/intel/i40e/i40e.h            |   2 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h |   2 +
 drivers/net/ethernet/intel/i40e/i40e_common.c     |  19 ++--
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c    |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 112 +++++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |  17 ++--
 drivers/net/ethernet/intel/i40evf/i40e_common.c   |  19 ++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |  17 ++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c   |   8 +-
 9 files changed, 145 insertions(+), 56 deletions(-)

-- 
2.4.11

