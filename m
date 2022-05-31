From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Tue, 31 May 2022 15:18:18 +0200
Subject: [Intel-wired-lan] [PATCH net v1 0/2] ice: Fix memory corruption in
 VF driver
Message-ID: <20220531131818.3411-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Disable VF queues, when VF requests reset. Add error handling for
VIRTCHNL_OP_CONFIG_VSI_QUEUES handler. Without this patch VF driver
could experience memory corruption, which lead to crash:
BUG: unable to handle kernel paging request at 00001b9780003237

Przemyslaw Patynowski (2):
  ice: Add error handling for queue config fail
  ice: Fix memory corruption in VF driver

 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  5 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 53 +++++++++----------
 2 files changed, 31 insertions(+), 27 deletions(-)

-- 
2.27.0

