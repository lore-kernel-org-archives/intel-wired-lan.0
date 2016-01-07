From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:10:16 -0800
Subject: [Intel-wired-lan] [next PATCH 00/11] Enable use of PF for switch or
 bridge when using SR-IOV
Message-ID: <20160107070850.13648.21033.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series addresses a number of issues in the configuration of
SR-IOV in conjunction with something such as a bridge or OVS.  As a result
the the functionality should be brought inline with what is now available
in ixgbe after recent changes.

It should now be possible to place bridge with tap interfaces on top of the
PF and as long as we add the MAC addresses for those interfaces using the
command "bridge fdb add ADDR dev DEV" we should be able to then pass
traffic between the VFs and those interfaces.

In addition I made one change to the configuration of the MTU.  Since we
are using page based receive I decided to configure the driver to support
always receiving jumbo frames, but only transmitting up to MTU.  This way
the behavior should be more consistent between SR-IOV and non-SR-IOV modes.

---

Alexander Duyck (11):
      igb: clean up code for setting MAC address
      igb: Refactor VFTA configuration
      igb: Allow asymmetric configuration of MTU versus Rx frame size
      igb: Do not factor VLANs into RLPML calculation
      igb: Always enable VLAN 0 even if 8021q is not loaded
      igb: Merge VLVF configuration into igb_vfta_set
      igb: Clean-up configuration of VF port VLANs
      igb: Add support for VLAN promiscuous with SR-IOV and NTUPLE
      igb: Drop unnecessary checks in transmit path
      igb: Enable use of "bridge fdb add" to set unicast table entries
      igb: Add workaround for VLAN tag stripping on 82576


 drivers/net/ethernet/intel/igb/e1000_82575.c   |   39 +
 drivers/net/ethernet/intel/igb/e1000_defines.h |    3 
 drivers/net/ethernet/intel/igb/e1000_hw.h      |    2 
 drivers/net/ethernet/intel/igb/e1000_mac.c     |  213 ++++---
 drivers/net/ethernet/intel/igb/e1000_mac.h     |    5 
 drivers/net/ethernet/intel/igb/igb.h           |    2 
 drivers/net/ethernet/intel/igb/igb_main.c      |  764 +++++++++++++-----------
 7 files changed, 610 insertions(+), 418 deletions(-)

--
