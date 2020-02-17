From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 17 Feb 2020 22:39:27 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/3] net: core: add helper
 tcp_v6_gso_csum_prep
Message-ID: <76cd6cfc-f4f3-ece7-203a-0266b7f02a12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several network drivers for chips that support TSO6 share the same code
for preparing the TCP header. A difference is that some reset the
payload_len whilst others don't do this. Let's factor out this common
code to a new helper.

Heiner Kallweit (3):
  net: core: add helper tcp_v6_gso_csum_prep
  r8169: use new helper tcp_v6_gso_csum_prep
  net: use new helper tcp_v6_gso_csum_prep

 drivers/net/ethernet/atheros/alx/main.c       |  5 +---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  6 ++---
 drivers/net/ethernet/brocade/bna/bnad.c       |  7 +----
 drivers/net/ethernet/cisco/enic/enic_main.c   |  3 +--
 drivers/net/ethernet/intel/e1000/e1000_main.c |  6 +----
 drivers/net/ethernet/intel/e1000e/netdev.c    |  5 +---
 drivers/net/ethernet/jme.c                    |  7 +----
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  5 +---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c |  7 ++---
 drivers/net/ethernet/realtek/r8169_main.c     | 26 ++-----------------
 drivers/net/ethernet/socionext/netsec.c       |  6 +----
 drivers/net/hyperv/netvsc_drv.c               |  5 +---
 drivers/net/usb/r8152.c                       | 26 ++-----------------
 drivers/net/vmxnet3/vmxnet3_drv.c             |  5 +---
 include/net/ip6_checksum.h                    | 12 +++++++++
 15 files changed, 30 insertions(+), 101 deletions(-)

-- 
2.25.0

