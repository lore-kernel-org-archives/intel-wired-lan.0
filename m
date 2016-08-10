From: Gangfeng <gangfeng.huang@ni.com>
Date: Wed, 10 Aug 2016 14:48:11 +0800
Subject: [Intel-wired-lan] [net-next] I210 qav mode support
Message-ID: <1470811692-24574-1-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The I210 supports two transmit modes, legacy and qav. In qav mode, I210
provide a way to guarantee bounded latency for time sensitive traffic.
This patch will provide a way for user to switch back and forth between
lagecy mode and qav mode.

Gangfeng Huang (1):
  igb: add function to set I210 transmit mode

 drivers/net/ethernet/intel/igb/e1000_defines.h |  21 +++
 drivers/net/ethernet/intel/igb/e1000_regs.h    |   7 +
 drivers/net/ethernet/intel/igb/igb.h           |   5 +
 drivers/net/ethernet/intel/igb/igb_main.c      | 178 ++++++++++++++++++++++++-
 4 files changed, 209 insertions(+), 2 deletions(-)

-- 
2.7.2

