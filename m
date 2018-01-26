From: Benjamin Poirier <bpoirier@suse.com>
Date: Fri, 26 Jan 2018 18:12:33 +0900
Subject: [Intel-wired-lan] [PATCH 0/3] e1000e: Revert interrupt handling
 changes
Message-ID: <20180126091236.13044-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As discussed in the thread "[RFC PATCH] e1000e: Remove Other from EIAC.",
https://www.spinics.net/lists/netdev/msg479311.html

The following list of commits was considered:
4d432f67ff00 e1000e: Remove unreachable code (v4.5-rc1)
16ecba59bc33 e1000e: Do not read ICR in Other interrupt (v4.5-rc1)
a61cfe4ffad7 e1000e: Do not write lsc to ics in msi-x mode (v4.5-rc1)
0a8047ac68e5 e1000e: Fix msi-x interrupt automask (v4.5-rc1)
19110cfbb34d e1000e: Separate signaling for link check/link up (v4.15-rc1)
4aea7a5c5e94 e1000e: Avoid receiver overrun interrupt bursts (v4.15-rc1)
4110e02eb45e e1000e: Fix e1000_check_for_copper_link_ich8lan return value. (v4.15-rc8)

There have a been a slew of regressions due to unforeseen consequences
(receive overflow triggers Other, vmware's emulated e1000e) and programming
mistakes (4110e02eb45e). Since the e1000e driver is supposed to be in
maintenance mode, this patch series revisits the above changes to prune
them down.

After this series, the remaining differences related to how interrupts were
handled at commit 4d432f67ff00 ("e1000e: Remove unreachable code",
v4.5-rc1) are:
* the changes in commit 0a8047ac68e5 ("e1000e: Fix msi-x interrupt
  automask", v4.5-rc1) are preserved.
* we manually clear Other from icr in e1000_msix_other().

We try to go back to a long lost time when things were simple and drivers
ran smoothly.

----------------------------------------------------------------
Benjamin Poirier (3):
  Partial revert "e1000e: Avoid receiver overrun interrupt bursts"
  Revert "e1000e: Separate signaling for link check/link up"
  Revert "e1000e: Do not read ICR in Other interrupt"

 drivers/net/ethernet/intel/e1000e/defines.h |  1 -
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 11 ++------
 drivers/net/ethernet/intel/e1000e/mac.c     | 11 ++------
 drivers/net/ethernet/intel/e1000e/netdev.c  | 44 ++++++++++++++---------------
 4 files changed, 27 insertions(+), 40 deletions(-)

-- 
2.15.1

