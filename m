From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  5 Oct 2016 09:30:30 -0700
Subject: [Intel-wired-lan] [next PATCH S49-V2 00/15] i40e-i40evf updates
Message-ID: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alan Brady adds code to fix mac filters when removing vlans.

Jacob Keller provides several patches to refactor handling of MAC 
filters and fix several issues, and improve code design. This 
includes removal of unnecessary tracking of VF and Netdev filters, 
as well as removal of a faulty debugfs command. Additionally he 
provides patches to fix an issue with PTP Rx timestamps, updating 
the logic for handling timestamps on discarded frames.

 drivers/net/ethernet/intel/i40e/i40e.h             |  50 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  92 +-
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 949 +++++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         | 137 +--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   2 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  57 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   8 +-
 9 files changed, 669 insertions(+), 647 deletions(-)

-- 
2.4.11

