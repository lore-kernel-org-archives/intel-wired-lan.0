From: Mario Limonciello <mario.limonciello@dell.com>
Date: Mon, 14 Dec 2020 09:34:46 -0600
Subject: [Intel-wired-lan] [PATCH v4 0/4] Improve s0ix flows for systems
 i219LM
Message-ID: <20201214153450.874339-1-mario.limonciello@dell.com>
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

Per discussion with Intel architecture team this direction should be changed and
allow S0ix flows to be used by default.  This patch series includes directional
changes for their conclusions in https://lkml.org/lkml/2020/12/13/15.

Changes from v3 to v4:
 - Drop patch 1 for proper s0i3.2 entry, it was separated and is now merged in kernel
 - Add patch to only run S0ix flows if shutdown succeeded which was suggested in
   thread
 - Adjust series for guidance from https://lkml.org/lkml/2020/12/13/15
   * Revert i219-LM disallow-list.
   * Drop all patches for systems tested by Dell in an allow list
   * Increase ULP timeout to 1000ms
Changes from v2 to v3:
 - Correct some grammar and spelling issues caught by Bjorn H.
   * s/s0ix/S0ix/ in all commit messages
   * Fix a typo in commit message
   * Fix capitalization of proper nouns
 - Add more pre-release systems that pass
 - Re-order the series to add systems only at the end of the series
 - Add Fixes tag to a patch in series.

Changes from v1 to v2:
 - Directly incorporate Vitaly's dependency patch in the series
 - Split out s0ix code into it's own file
 - Adjust from DMI matching to PCI subsystem vendor ID/device matching
 - Remove module parameter and sysfs, use ethtool flag instead.
 - Export s0ix flag to ethtool private flags
 - Include more people and lists directly in this submission chain.

Mario Limonciello (4):
  e1000e: Only run S0ix flows if shutdown succeeded
  e1000e: bump up timeout to wait when ME un-configure ULP mode
  Revert "e1000e: disable s0ix entry and exit flows for ME systems"
  e1000e: Export S0ix flags to ethtool

 drivers/net/ethernet/intel/e1000e/e1000.h   |  1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c | 40 ++++++++++++++
 drivers/net/ethernet/intel/e1000e/ich8lan.c |  4 +-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 59 ++++-----------------
 4 files changed, 53 insertions(+), 51 deletions(-)

--
2.25.1

