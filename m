From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue, 23 Aug 2016 00:43:07 +0200
Subject: [Intel-wired-lan] [dev-queue PATCH v3 0/3] i40e: Add VF Port
	representor support for SR-IOV VFs
Message-ID: <1471905790-4222-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Patch 1 in this patchset adds support to create VF port representor netdevs
associated with SR-IOV VFs that can be used to control/configure VFs from
PF name space.
Patch 2 enables VF statistics to be exposed via ethtool on VF representor
netdevs.
Patch 3 adds devlink interface to change the switch mode to control the
creation of VF representor netdevs.

v3:
Swapped TX and RX ethtool stat strings for VFPR netdevs to indicate that
they represent the switch port attached to the VF.

v2:
Made following changes based on Alex's feedback
- reorganized the patches to create VF Port representor netdevs
  by default.
- removed support for ntuple filters on VFPR's

Sridhar Samudrala (3):
  i40e: Introduce VF port representor/control netdevs.
  i40e: Enable VF specific ethtool statistics via VF Port representor
    netdevs.
  i40e: Introduce devlink interface.

 drivers/net/ethernet/intel/Kconfig                 |  1 +
 drivers/net/ethernet/intel/i40e/i40e.h             |  4 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 72 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 91 ++++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 91 ++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 14 ++++
 6 files changed, 265 insertions(+), 8 deletions(-)

-- 
2.5.5

