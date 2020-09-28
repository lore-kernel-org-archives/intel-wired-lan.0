From: Mario Limonciello <mario.limonciello@dell.com>
Date: Sun, 27 Sep 2020 23:40:21 -0500
Subject: [Intel-wired-lan] [PATCH 0/3] Improve s0ix flows for systems i219LM
Message-ID: <20200928044024.7595-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

commit e086ba2fccda ("e1000e: disable s0ix entry and exit flows for ME systems")
disabled s0ix flows for systems that have various incarnations of the
i219-LM ethernet controller.  This was done because of some regressions
caused by an earlier
commit 632fbd5eb5b0e ("e1000e: fix S0ix flows for cable connected case")
with i219-LM controller.

Performing suspend to idle with these ethernet controllers requires a properly
configured system.  To make enabling such systems easier, this patch
series offers configuration options to enable/disable the flows.

The flows have also been confirmed to be configured correctly on Dell's Latitude
and Precision CML systems containing the i219-LM controller, when the kernel also
contains the fix for s0i3.2 entry here:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20200914/021361.html

Patches 2 and 3 will turn the behavior on by default for Dell's CML systems.
These patches should only be carried if that patch linked above is also applied.

Mario Limonciello (3):
  e1000e: allow turning s0ix flows on for systems with ME
  e1000e: Add Dell's Comet Lake systems into s0ix heuristics
  e1000e: Add more Dell CML systems into s0ix heuristics

 .../device_drivers/ethernet/intel/e1000e.rst  |  23 ++
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |   7 +
 drivers/net/ethernet/intel/e1000e/netdev.c    |  64 +++---
 drivers/net/ethernet/intel/e1000e/param.c     | 209 ++++++++++++++++++
 5 files changed, 266 insertions(+), 38 deletions(-)

-- 
2.25.1

