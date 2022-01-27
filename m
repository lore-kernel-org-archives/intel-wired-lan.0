From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Thu, 27 Jan 2022 15:16:16 +0100
Subject: [Intel-wired-lan] [PATCH net-next v3 0/2] iavf: Fix return values
 in driver
Message-ID: <20220127141616.27908-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several functions in the iAVF core files take status values of the enum
iavf_status and convert them into integer values. This leads to
confusion as functions return both Linux errno values and status codes
intermixed.Fix this by introducing iavf_status_to_errno, a switch that explicitly
converts from the status codes into an appropriate error value.
---
 v2: Submit this with additional patch introducing iavf_status_to_errno function
 v3: Change iavf_poll_virtchnl_msg to int
---
Mateusz Palczewski (2):
  iavf-linux: stop leaking iavf_status as "errno" values
  iavf: Fix incorrect use of assigning iavf_status to int

 drivers/net/ethernet/intel/iavf/iavf.h        |   5 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 172 ++++++++++++++---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 178 ++++++++----------
 3 files changed, 224 insertions(+), 131 deletions(-)

-- 
2.27.0

