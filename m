From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Wed, 28 Oct 2015 13:33:09 +0800
Subject: [Intel-wired-lan] [PATCH net-next 0/2] Add I210 AVB support
Message-ID: <1446010391-14421-1-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The Intel Ethernet Server Adapter I210 supports IEEE 802.1Qav Audio-Video
Bridging (AVB) for users requiring tightly controlled media stream
synchronization, buffering, and reservation. The 802.1Qav is part of the
AVB specification that provides a way to guarantee bounded latency and
latency variation for time sensitive traffic.

Reference:
https://github.com/AVnu/Open-AVB/tree/master/kmod/igb

Gangfeng Huang (2):
  igb: add function to set I210 transmit mode
  igb: add a character device to support AVB

 drivers/net/ethernet/intel/igb/Makefile        |    2 +-
 drivers/net/ethernet/intel/igb/e1000_defines.h |   22 +
 drivers/net/ethernet/intel/igb/e1000_regs.h    |    7 +
 drivers/net/ethernet/intel/igb/igb.h           |   19 +-
 drivers/net/ethernet/intel/igb/igb_cdev.c      |  511 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_cdev.h      |   45 +++
 drivers/net/ethernet/intel/igb/igb_main.c      |  286 ++++++++++++-
 7 files changed, 877 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_cdev.c
 create mode 100644 drivers/net/ethernet/intel/igb/igb_cdev.h

-- 
1.7.9.5

