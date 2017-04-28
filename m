From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 28 Apr 2017 16:53:14 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 0/3] i40e/i40evf: small fixes
Message-ID: <1493423597-18306-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a quick series of fixes that were found when reviewing
code.

Jesse Brandeburg (3):
  i40evf: fix duplicate lines
  i40evf: fix merge error in older patch
  i40evf: disable unused flags

 drivers/net/ethernet/intel/i40evf/i40e_common.c     | 3 +--
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h   | 3 +--
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
1.8.3.1

