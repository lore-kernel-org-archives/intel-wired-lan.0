From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Feb 2016 16:12:10 -0800
Subject: [Intel-wired-lan] [next PATCH S29 00/14] i40e/i40evf updates
Message-ID: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Joshua Hay <joshua.a.hay@intel.com>

Anjali Singhai Jain has provided access to some registers to program parser, 
	FD and RSS logic

Carolyn Wyborny has added functions to blink led on 10GBaseT PHY,
 	fixed led blink capability for 10GBaseT PHY, provided fix 
	for unexpected messaging

Catherine Sullivan has added a client definition of I40E_MAX_USER_PRIORITY

Jesse Brandeburg created a bump patch i40e to 1.4.25 and i40evf to 1.4.15

John Underwood has provided fix for PSOD's when npar is enabled

Kevin Scott has increased timeout when checking GLGEN_RSTAT_DEVSTATE bit

Mitch Williams provided the refreshing of VSI pointer when VF is reset

Neerav Parikh disabled the wait for Rx queue disable in DCB reconfig

Pandi Kumar Maharajan provided fix for the NPAR PSOD issue

Shannon Nelson has implemented and used rx ctl helper functions, added adminq 
	commands for rx ctl registers, avoids using AQ calls from clear_hw.

 drivers/net/ethernet/intel/i40e/i40e.h             |   6 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  16 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 489 ++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  44 +-
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  80 ++--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  21 +
 drivers/net/ethernet/intel/i40e/i40e_register.h    |  48 ++
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  16 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   9 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  16 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c    | 125 ++++++
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h |  15 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   2 +-
 14 files changed, 847 insertions(+), 48 deletions(-)

-- 
2.1.0

