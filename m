From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Feb 2020 20:55:18 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 0/13] net: core: add helper
 tcp_v6_gso_csum_prep
Message-ID: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several network drivers for chips that support TSO6 share the same code
for preparing the TCP header, so let's factor it out to a helper.
A difference is that some drivers reset the payload_len whilst others
don't do this. This value is overwritten by TSO anyway, therefore
the new helper resets it in general.

Heiner Kallweit (13):
  net: core: add helper tcp_v6_gso_csum_prep
  r8169: use new helper tcp_v6_gso_csum_prep
  net: atheros: use new helper tcp_v6_gso_csum_prep
  bna: use new helper tcp_v6_gso_csum_prep
  enic: use new helper tcp_v6_gso_csum_prep
  e1000(e): use new helper tcp_v6_gso_csum_prep
  jme: use new helper tcp_v6_gso_csum_prep
  ionic: use new helper tcp_v6_gso_csum_prep
  net: qcom/emac: use new helper tcp_v6_gso_csum_prep
  net: socionext: use new helper tcp_v6_gso_csum_prep
  hv_netvsc: use new helper tcp_v6_gso_csum_prep
  r8152: use new helper tcp_v6_gso_csum_prep
  vmxnet3: use new helper tcp_v6_gso_csum_prep

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
 include/net/ip6_checksum.h                    |  9 +++++++
 15 files changed, 27 insertions(+), 101 deletions(-)

-- 
2.25.1

