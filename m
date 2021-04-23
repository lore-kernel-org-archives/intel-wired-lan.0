From: Eryk Rybak <eryk.roch.rybak@intel.com>
Date: Fri, 23 Apr 2021 13:43:24 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1 0/2] Fix ping is lost after
 configuring ADq on VF
Message-ID: <20210423114326.22393-1-eryk.roch.rybak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Properly reconfigure VF VSIs after VF request ADq.
Previously, VF main VSI in ADq had configured too many queues and had wrong
RSS size, which lead to packets not being consumed and drops 
in connectivity. Additionally, added setting vsi-> req_queue_pairs as 
the number of queues that will be distributed among the various TCs. 
Do it for non-zero values,which means the user requested a new number 
of queues.

The result is VF has ability to ping with ADq configured.

Eryk Rybak (2):
  i40e: Fix changing previously set num_queue_pairs for PFs
  i40e: Fix ping is lost after configuring ADq on VF

 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 89 ++++++++++++++++---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 17 ++--
 3 files changed, 91 insertions(+), 16 deletions(-)


base-commit: 5ee9f22fb30f02076233f8fb105f83ff68fe6dbc
-- 
2.20.1

