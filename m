From: Joshua Hay <joshua.a.hay@intel.com>
Date: Mon, 11 Jan 2016 15:18:12 -0800
Subject: [Intel-wired-lan] [next PATCH S27 00/15] i40e/i40evf updates
Message-ID: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain refactors force_wb and WB_ON_ITR functionality code.

Catherine Sullivan changes vf driver string to reflect all products 
i40evf supports.

Jesse Brandeburg moves sync_vsi_filters up in service task, doesn't lose 
interrupts, tries again after failure, dumps descriptor indexes in hex,
uses __GFP_NOWARN, bumps version.

Mitch Williams uses pages correctly in rx, uses logical operators, 
not bitwise, properly shows packet split status in debugfs.

Neerav Parikh makes the DCB firmware checks for X710/XL710 only.

Shannon Nelson sets shared bit for multicast filters, adds VEB stat
control and removes L2 cloud filter, uses new add_veb calling with 
veb stats control.

 drivers/net/ethernet/intel/i40e/i40e.h             |  23 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  21 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  25 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  51 +++--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 249 +++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   4 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 253 ++++++++++++++-------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  10 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   6 +-
 12 files changed, 445 insertions(+), 223 deletions(-)

-- 
2.1.0

