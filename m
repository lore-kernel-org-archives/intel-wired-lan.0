From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 11 Jun 2021 11:59:14 +0200
Subject: [Intel-wired-lan] [PATCH net v2 0/2] iavf: Fix init and watchdog
 state machines
Message-ID: <20210611095914.4832-1-mateusz.palczewski@intel.com>
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
v2: Splitted the patch into 2 to make them smaller
---

Jan Sokolowski (2):
  iavf: Refactor iavf state machine tracking
  iavf: Fix init and watchdog state machines

 drivers/net/ethernet/intel/iavf/iavf.h        |  12 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 189 +++++++++---------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
 3 files changed, 103 insertions(+), 100 deletions(-)

-- 
2.27.0

