From: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
Date: Mon, 27 Mar 2017 08:44:34 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Enable reading of wake up packet
Message-ID: <1490575475-8215-1-git-send-email-kim.tatt.chuah@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The Intel i210 NIC supports wake from multiple packet types and stores the wake
up packet. However, the current igb driver ignores the Wake Up Status (WUS)
and Wake Up Packet Memory (WUPM) registers during resume. This causes the
Ethernet controller to drop the packet that caused the wake, causing the
remote to time out and having to re-send the packet. This has been seen to
cause issues with certain managed-switches, where the switch stops routing
packets to the i210-attached host.

This patch enables the igb driver to read the WUPM if the controller was woken
by a wake up packet that is not more than 128 bytes long (maximum WUPM size),
then pass it up the kernel network stack.

This patch is applied on net-next.

Chuah, Kim Tatt (1):
  igb: Enable reading of wake up packet

 drivers/net/ethernet/intel/igb/e1000_defines.h | 21 +++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c      | 36 +++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

-- 
1.9.1

