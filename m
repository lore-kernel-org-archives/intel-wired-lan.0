From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 28 Jun 2021 15:15:14 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 0/3] iavf: Fix init and
 watchdog state machines
Message-ID: <20210628151514.28547-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use single state machine for driver initialization
and for service initialized driver. The init state
machine implemented in init_task() is merged
into the watchdog_task(). The init_task() function
is removed.

---
v5: Fixed the patch so that it applies on net-next tree
v4: Removed unnecessary line
v3: Added new file to patch series
v2: Splitted the patch into 2 to make them smaller
---

Jan Sokolowski (3):
  iavf: Refactor iavf state machine tracking
  iavf: Add __IAVF_INIT_FAILED state
  iavf: Fix init and watchdog state machines


 drivers/net/ethernet/intel/iavf/iavf.h        |  12 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 190 +++++++++---------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
 3 files changed, 103 insertions(+), 101 deletions(-)

-- 
2.17.1

