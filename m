From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 27 Jul 2016 12:02:29 -0700
Subject: [Intel-wired-lan] [next PATCH S40-V2 00/12] i40e/i40evf updates
Message-ID: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain fixes a bug where a client close can be called
before an open is complete.

Avinash Dayanand adds code to force register writes to mitigate sync issues
with iwarp VF driver & adds code to not notify client of VF reset during VF
creation.

Alan Brady fixes lookup table when RSS disabled/enabled.

Carolyn Wyborny adds code to allow RSS Hash set with less than four parameters.

Catherine Sullivan adds code to reset vlan filter count when resetting and
adds code to reset RX csum error stat with other pf stats.

Dave Ertman fixes static analysis tool warning.

Jacob Keller adds code for missing rtnl_lock() around i40evf_set_interrupt_
capability and adds code to not allow reduction of channels below active FD
rules.

Mitch Williams fixes memory leak.

 drivers/net/ethernet/intel/i40e/i40e.h             |   3 -
 drivers/net/ethernet/intel/i40e/i40e_client.c      |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 232 ++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  35 +++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   9 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   4 +-
 6 files changed, 199 insertions(+), 89 deletions(-)

-- 
2.4.11

