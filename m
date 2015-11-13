From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 15:47:00 -0800
Subject: [Intel-wired-lan] [next PATCH S22 00/15] i40e/i40evf updates
Message-ID: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain adds a Virtchnl offload for RSS PCTYPE V2, and a new
offload for RSS PCTYPE V2. 

Jesse Brandeburg chomps the BIT(_ULL), fixes mismatched declaration, and also
fixes W=1 warning.

Kamil Krawczyk adds 'use explicit cast from u16 to u8'.

Michal Kosiarz adds opcode and structures required by OEM Post Update AQ
command and a new NVM arq message.

Mitch Williams adds proper deletion of VF MAC filters, and removes zero MAC
filter. Also checks rings before freeing resources, changes version string 
generation, and adds hush little warnings.

Shannon Nelson cleans whole mac filter list.

 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  21 +++++
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 105 +++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  23 +++--
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  21 +++++
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |   1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  27 ++++--
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   4 +-
 10 files changed, 162 insertions(+), 47 deletions(-)

-- 
2.1.0

