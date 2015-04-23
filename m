From: Fan Du <fan.du@intel.com>
Date: Thu, 23 Apr 2015 15:31:08 +0800
Subject: [Intel-wired-lan] [PATCH 0/2] RSS fix for ixgbe/ixgbevf
Message-ID: <1429774270-21344-1-git-send-email-fan.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset provide RSS hash value for upper stack by indicating
whether it's a L3 or L4 hash. Thus other component of network
stack could utilize this hash value providing by NIC without caculating
by themselves.

Test:
* Simple iperf test using ixgbe for 82599ES
* Build test only for ixgbevf
* make C=1 CF=-D__CHECK_ENDIAN__, no warnings introduced by this patchset

Fan Du (2):
  ixgbe: Specify rx hash type wrt rx desc RSS type
  ixgbevf: Set rx hash type for ingress packets

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   25 ++++++++++++++++---
 drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 +++++++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   27 +++++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

