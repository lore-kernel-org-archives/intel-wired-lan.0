From: Chen Yu <yu.c.chen@intel.com>
Date: Thu, 26 Nov 2020 14:14:15 +0800
Subject: [Intel-wired-lan] [PATCH 0/2][v2] Leverage runtime suspend to speed
 up the s2ram on e1000e
Message-ID: <cover.1606370334.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The NIC is put in runtime suspend status when there is no cable connected.
As a result, it is safe to keep non-wakeup NIC in runtime suspended during
s2ram because the system does not rely on the NIC plug event nor WoL to wake
up the system. After doing this, the s2ram could speed up the suspend/resume
process a lot.

Chen Yu (2):
  e1000e: Assign DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME to
    speed up s2ram
  e1000e: Remove the runtime suspend restriction on CNP+

 drivers/base/power/main.c                  |  2 ++
 drivers/net/ethernet/intel/e1000e/netdev.c | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1

