From: Fan Du <fan.du@intel.com>
Date: Wed, 29 Apr 2015 10:57:38 +0800
Subject: [Intel-wired-lan] [PATCH v2 0/3] RSS fix for ixgbe/ixgbevf
Message-ID: <1430276261-29821-1-git-send-email-fan.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset provides RSS hash value for upper stack by indicating
whether it's a L3 or L4 hash. Thus other component of network
stack could utilize this hash value provided by NIC without caculating
by themselves.

Test:
* Simple iperf test using ixgbe for 82599ES
* Build test only for ixgbevf
* make C=1 CF=-D__CHECK_ENDIAN__, no warnings introduced by this patchset

Changelog:
v2:
  - Add patch3 to make all hash value from RSS part.
v1:
  - Code style issue suggeted by Tantilov, Emil S.
  - Initial version

Fan Du (3):
  ixgbe: Specify rx hash type wrt rx desc RSS type
  ixgbevf: Set rx hash type for ingress packets
  ixgbe: Don't report flow director filter's status

 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c    |    2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   25 ++++++++++++++++---
 drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 +++++++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   27 +++++++++++++++++++++
 4 files changed, 60 insertions(+), 6 deletions(-)

