From: Chen Yu <yu.c.chen@intel.com>
Date: Wed, 11 Nov 2020 13:50:35 +0800
Subject: [Intel-wired-lan] [PATCH 0/4][RFC] Disable e1000e power management
 if hardware error is detected
Message-ID: <cover.1605073208.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is a trial patchset that aims to cope with an intermittently
triggered hardware error during system resume.

On some platforms the NIC's hardware error was detected during
resume from S3, causing the NIC to not fully initialize
and remain in unstable state afterwards. As a consequence
the system fails to suspend due to incorrect NIC status.

In theory if the NIC could not be initialized after resumed,
it should not do system/runtime suspend/resume afterwards.
There are two proposals to deal with this situation:

Either:
1. Each time before the NIC going to suspend, check the status
   of NIC by querying corresponding registers, bypass the suspend
   callback on this NIC if it's unstable.

Or:
2. During NIC resume, if the hardware error was detected, removes
   the NIC from power management list entirely.

Proposal 2 was chosen in this patch set because:
1. Proposal 1 requires that the driver queries the status
   of the NIC in e1000e driver. However there seems to be
   no specific registers for the e1000e to query the result
   of NIC initialization.
2. Proposal 1 just bypass the suspend process but the power management
   framework is still aware of this NIC, which might bring potential issue
   in race condition.
3. Approach 2 is a clean solution and it is platform independent
   that, not only e1000e, but also other drivers could leverage
   this generic mechanism in the future.

Comments appreciated.

Chen Yu (4):
  e1000e: save the return value of e1000e_reset()
  PM: sleep: export device_pm_remove() for driver use
  e1000e: Introduce workqueue to disable the power management
  e1000e: Disable the power management if hardware error detected during
    resume

 drivers/base/power/main.c                  |  1 +
 drivers/base/power/power.h                 |  8 -------
 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 27 ++++++++++++++++++----
 include/linux/pm.h                         | 12 ++++++++++
 5 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.17.1

