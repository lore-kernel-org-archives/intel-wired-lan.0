From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 24 Aug 2016 11:33:45 -0700
Subject: [Intel-wired-lan] [next PATCH S44 0/6] i40e/i40evf updates
Message-ID: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alan Brady adds code to fix setting user defined RSS hash key & fix 
"dump port" command when NPAR enabled.

Anjali Singhai Jain adds code to change some init flow for the client.

Carolyn Wyborny adds code to fix to check for NULL & fix for extra byte 
swap in tunnel setup.

Mitch Williams adds code to return correct opcode to VF.

 drivers/net/ethernet/intel/i40e/i40e.h             |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_client.c      | 41 ++++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  7 +++-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 13 +++----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 15 ++++++--
 6 files changed, 62 insertions(+), 28 deletions(-)

-- 
2.4.11

