From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 14:07:04 -0700
Subject: [Intel-wired-lan] [PATCH 0/6] ixgbe: Add KR and SFP+ interfaces to
	X550EM_A
Message-ID: <20160318210612.41255.22539.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following patches add support for two more interfaces for the
X550EM_A mac: KR backplane and SFP+ with a retimer.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

---

Mark D Rustad (6):
      ixgbe: Add KR backplane support for X550EM_A
      ixgbe: Request token for phy accesses
      ixgbe: Read and set instance id
      ixgbe: Read and parse NW_MNG_IF_SEL register
      ixgbe: Introduce function to control MDIO speed
      ixgbe: Add support for SFPs with retimer


 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    8 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c    |   34 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h    |    6 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |   17 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |  178 +++++++++++++++++++++--
 6 files changed, 216 insertions(+), 31 deletions(-)

-- 
Mark Rustad, Network Division, Intel Corporation
