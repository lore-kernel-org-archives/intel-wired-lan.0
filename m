From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Thu, 29 Sep 2016 10:11:20 -0700
Subject: [Intel-wired-lan] [next PATCH S49 00/15] i40e/i40evf updates
Message-ID: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alan Brady adds code to fix mac filters when removing vlans.

Jacob Keller drops is_vf and is_netdev fields in struct 
i40e_mac_filter, adds code to make use of __dev_uc_sync 
and __dev_mc_sync, moves i40e_put_mac_in_vlan and 
i40e_del_mac_all_vlan, fixes i40e_put_mac_in_vlan to 
return actual filter added, adds code to ignore removed 
filters When searching all MAC/VLAN filters, implements 
__i40e_del_filter and use where applicable, adds code to 
store MAC/VLAN filters in a hash with the MAC Address as 
key, adds code to properly cleanup on allocation failure 
in i40e_sync_vsi_filters, adds code to avoid looping to 
check whether we're in vlan mode, removes duplicate add/
delete adminq command code for filters, corrects check 
for reading TSYNINDX from the receive descriptor, uses a 
mutex instead of spinlock in PTP user entry points, replaces 
PTP Rx timestamp hang logic and adds code to avoid an extra 
msleep while waiting for reset.

 drivers/net/ethernet/intel/i40e/i40e.h             |  50 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  92 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 949 +++++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         | 137 +--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   2 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  57 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   8 +-
 8 files changed, 663 insertions(+), 641 deletions(-)

-- 
2.4.11

