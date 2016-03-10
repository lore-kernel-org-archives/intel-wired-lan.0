From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:38 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 00/13] i40e/i40evf updates
Message-ID: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

Catherine Sullivan has removed I40E_MAX_USER_PRIORITY define.

Jesse Brandeburg has fixed up the return code and added code
to fix casting in transmit code.

Kevin Scott has added code to save off VSI resource count when updating VSI.

Mitch Williams has added code to notify VFs of all resets.
Added code to prevent double resets. Adds additional check for reset.
Changed the comment to reflect correct function name.

Shannon Nelson has added code to remove msix only if created.
Added code to assure that adminq is alive in debug mode.
Added code to remove timer and task only if created.
Added code to change unknown event error msg to ignore message.

 drivers/net/ethernet/intel/i40e/i40e.h             |  1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 12 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 31 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  5 ++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 13 +++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  5 ++--
 drivers/net/ethernet/intel/i40evf/i40e_type.h      | 16 +++++++++++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  6 +++--
 8 files changed, 59 insertions(+), 30 deletions(-)

-- 
2.4.3

