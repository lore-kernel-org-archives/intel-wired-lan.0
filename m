From: Ederson de Souza <ederson.desouza@intel.com>
Date: Thu, 18 Feb 2021 17:31:02 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 0/2] PPS and SDP support for
 i225
Message-ID: <20210219013104.54436-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The i225 device has some PHC Hardware Clock features such as Pulse Per
Seconds interrupts or Software Defined Pins signals. This series add
support to some of them.

Changes from v1:
  - Addressed some checkpatch issues. However, most of them were about
  using BIT macro in code blocks whose readability would get worse in
  case I used it. Think of a some (1 << X) in the middle of (2 << Y).

  - Added more information on commit messages - trying to highlight some
  implementation details. However, the datasheet that is reference for
  these changes is not public yet, so I didn't mention it. As a
  workaround, I mention that most of it is the same as i210.

Ederson de Souza (2):
  igc: Enable internal i225 PPS
  igc: enable auxiliary PHC functions for the i225

 drivers/net/ethernet/intel/igc/igc.h         |  13 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  63 ++++
 drivers/net/ethernet/intel/igc/igc_main.c    |  63 +++-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 295 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_regs.h    |  10 +
 5 files changed, 441 insertions(+), 3 deletions(-)

-- 
2.30.1

