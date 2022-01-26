From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 26 Jan 2022 15:59:21 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 0/2] iavf: Fix return values
 in driver
Message-ID: <20220126145921.26334-1-mateusz.palczewski@intel.com>
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
---
Mateusz Palczewski (2):
  iavf-linux: stop leaking iavf_status as "errno" values
  iavf: Fix incorrect use of assigning iavf_status to int

 drivers/net/ethernet/intel/iavf/iavf.h        |   5 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 160 +++++++++++++---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 178 ++++++++----------
 3 files changed, 218 insertions(+), 125 deletions(-)

-- 
2.27.0

