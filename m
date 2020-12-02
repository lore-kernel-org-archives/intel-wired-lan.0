From: Mario Limonciello <mario.limonciello@dell.com>
Date: Wed,  2 Dec 2020 10:17:43 -0600
Subject: [Intel-wired-lan] [PATCH v2 0/5] Improve s0ix flows for systems
 i219LM
Message-ID: <20201202161748.128938-1-mario.limonciello@dell.com>
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
series allows turning on using ethtool.

The flows have also been confirmed to be configured correctly on Dell's Latitude
and Precision CML systems containing the i219-LM controller, when the kernel also
contains the fix for s0i3.2 entry previously submitted here:
https://marc.info/?l=linux-netdev&m=160677194809564&w=2

Patches 3 and 4 will turn the behavior on by default for Dell's CML systems.
Patch 5 allows accessing the value of the flags via ethtool to tell if the
heuristics have turned on s0ix flows, as well as for development purposes
to determine if a system should be added to the heuristics list.

Changes from v1 to v2:
 - Directly incorporate Vitaly's dependency patch in the series
 - Split out s0ix code into it's own file
 - Adjust from DMI matching to PCI subsystem vendor ID/device matching
 - Remove module parameter and sysfs, use ethtool flag instead.
 - Export s0ix flag to ethtool private flags
 - Include more people and lists directly in this submission chain.

Mario Limonciello (4):
  e1000e: Move all s0ix related code into it's own source file
  e1000e: Add Dell's Comet Lake systems into s0ix heuristics
  e1000e: Add more Dell CML systems into s0ix heuristics
  e1000e: Export adapter flags to ethtool

Vitaly Lifshits (1):
  e1000e: fix S0ix flow to allow S0i3.2 subset entry

 drivers/net/ethernet/intel/e1000e/Makefile  |   2 +-
 drivers/net/ethernet/intel/e1000e/e1000.h   |   4 +
 drivers/net/ethernet/intel/e1000e/ethtool.c |  23 ++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 272 +----------------
 drivers/net/ethernet/intel/e1000e/s0ix.c    | 308 ++++++++++++++++++++
 5 files changed, 341 insertions(+), 268 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/e1000e/s0ix.c

--
2.25.1

