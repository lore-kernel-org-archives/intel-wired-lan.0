From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 16 Jan 2021 14:13:36 +0800
Subject: [Intel-wired-lan] [PATCH net-next 0/6] net: support SCTP CRC csum
 offload for tunneling packets in some drivers
Message-ID: <cover.1610777159.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset introduces inline function skb_csum_is_sctp(), and uses it
to validate it's a sctp CRC csum offload packet, to make SCTP CRC csum
offload for tunneling packets supported in some HW drivers.

Xin Long (6):
  net: add inline function skb_csum_is_sctp
  net: igb: use skb_csum_is_sctp instead of protocol check
  net: igbvf: use skb_csum_is_sctp instead of protocol check
  net: igc: use skb_csum_is_sctp instead of protocol check
  net: ixgbe: use skb_csum_is_sctp instead of protocol check
  net: ixgbevf: use skb_csum_is_sctp instead of protocol check

 drivers/net/ethernet/intel/igb/igb_main.c         | 14 +-------------
 drivers/net/ethernet/intel/igbvf/netdev.c         | 14 +-------------
 drivers/net/ethernet/intel/igc/igc_main.c         | 14 +-------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 14 +-------------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 14 +-------------
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c  |  2 +-
 include/linux/skbuff.h                            |  5 +++++
 net/core/dev.c                                    |  2 +-
 8 files changed, 12 insertions(+), 67 deletions(-)

-- 
2.1.0

