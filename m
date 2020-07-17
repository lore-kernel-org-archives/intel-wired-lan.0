From: Li RongQing <lirongqing@baidu.com>
Date: Fri, 17 Jul 2020 14:24:20 +0800
Subject: [Intel-wired-lan] [PATCH 0/2] intel/xdp fixes for fliping rx buffer
Message-ID: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes ice/i40e/ixgbe/ixgbevf_rx_buffer_flip in
copy mode xdp that can lead to data corruption.

I split two patches, since i40e/xgbe/ixgbevf supports xsk
receiving from 4.18, put their fixes in a patch 

Li RongQing (2):
  xdp: i40e: ixgbe: ixgbevf: not flip rx buffer for copy mode xdp
  ice/xdp: not adjust rx buffer for copy mode xdp

 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c         | 5 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 5 ++++-
 include/net/xdp.h                                 | 3 +++
 net/xdp/xsk.c                                     | 4 +++-
 6 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.16.2

