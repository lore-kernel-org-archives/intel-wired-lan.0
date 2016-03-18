From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 18 Mar 2016 16:11:08 -0700
Subject: [Intel-wired-lan] [PATCH 0/2] ixgbe spoof checking refactor
Message-ID: <20160318225046.25773.35723.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following series changes the way we configure spoofing for ixgbe
when in SRIOV mode. 

With these changes spoof checking is unconditionally controlled via the
spoofchk option of the ip tool. Before we had MAC and Ethertype spoofing 
enabled by default. VLAN spoofing was only enabled if the VF had VLANs 
configured and Ethertype was always enabled and could not be disabled by 
the user.

In addition to making the spoof checking more consistent these patches
also fix some bugs where VLAN spoofing was not being set correctly or
could not be disabled in certain cases.

---

Emil Tantilov (2):
      ixgbe: consolidate the configuration of spoof checking
      ixgbe: set vlan spoof checking unconditionally


 drivers/net/ethernet/intel/ixgbe/ixgbe.h        |    3 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   40 ++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |   30 +----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  |   65 ++++++++++-------------
 5 files changed, 43 insertions(+), 97 deletions(-)

--
