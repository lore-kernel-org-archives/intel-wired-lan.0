From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 30 Mar 2016 03:49:35 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S32 00/13] i40e/i40evf updates
Message-ID: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Akeem G Abodunrin moves the HW flush to avoid problems in
pass-through routines. 

Anjali Singhai Jain adds a hook to support trusted VF.

Deepthi Kavalur adds capability to display HW information.

Harshitha Ramamurthy bumps i40e/i40evf from 1.5.2 to 1.5.5.

Jesse Brandeburg moves a stack variable deeper, drops unused 
tx_ring arguments and makes RX faster via avoiding FCOE.

Kiran Patil defines input set mask constants for RSS,
flow director and flex bytes.

Mitch Williams adds RSS configuration to the virtual channel.

Shannon Nelson ensures device capabilities do not get printed 
when not needed, adds code to restrict VF poll mode to only 
single function mode devices, moves NVM variable out of AQ 
struct and moves nvm event wait check to nvm code.

 drivers/net/ethernet/intel/i40e/i40e_adminq.c      | 33 +-------------
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |  1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  3 ++
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c        | 12 +----
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 43 +++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 17 ++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        | 10 ++++
 drivers/net/ethernet/intel/i40e/i40e_type.h        | 43 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    | 45 ++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 53 +++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  2 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h    |  1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 13 +++---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      | 10 ++++
 drivers/net/ethernet/intel/i40evf/i40e_type.h      | 43 ++++++++++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  | 45 ++++++++++++++++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  2 +-
 19 files changed, 308 insertions(+), 73 deletions(-)

-- 
2.4.3

