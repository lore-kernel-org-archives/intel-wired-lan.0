From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  1 Oct 2015 14:37:33 -0400
Subject: [Intel-wired-lan] [next PATCH S18 0/8] i40e/i40evf updates
Message-ID: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem fixes VEB/VEPA bridge mode mismatch issue and disables VEB bridge
mode when there is an SR-IOV failure.

Anjali adds a workaround to drop all flow control frames, fixes a bug in
debugfs with add/del macaddr.

Carolyn fixes an incorrect OEM version string.

Helin fixes inconsistent statuses after a PF reset.

Mitch uses correct struct for list manipulation.


 drivers/net/ethernet/intel/i40e/i40e.h             | 17 +++++--
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 22 +++++++++
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  4 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 56 ++++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  2 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h |  2 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  7 +--
 8 files changed, 100 insertions(+), 11 deletions(-)

-- 
1.9.3

