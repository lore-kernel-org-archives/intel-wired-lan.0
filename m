From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 16:30:57 -0700
Subject: [Intel-wired-lan] [rc2 00/15] Fixups for previous series
Message-ID: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sorry for the thrash, I found some issues I should have checked before
emailing. I've fixed up the issues found by checkpatch and ensured it
compiles cleanly now.

Jacob Keller (15):
  fm10k: ignore invalid multicast address entries
  fm10k: use correct ethernet driver Tx timestamp function
  fm10k: move setting shinfo inside ts_tx_enqueue
  fm10k: fix incorrect free on skb in ts_tx_enqueue
  fm10k: add call to fm10k_clean_all_rx_rings in fm10k_down
  fm10k: use an unsigned int for i in ethtool_get_strings
  fm10k: remove extraneous NULL check on l2_accel
  fm10k: trivial fixup message style to include a colon
  fm10k: use dma_set_mask_and_coherent in fm10k_probe
  fm10k: force LPORT delete when updating VLAN or MAC address
  fm10k: re-map all possible VF queues after a VFLR
  fm10k: pack TLV overlay structures
  fm10k: fix incorrect DIR_NEVATIVE bit in 1588 code
  fm10k: remove err_no reference in fm10k_mbx.c
  fm10k: fix iov_msg_lport_state_pf issue

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |  2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c     | 38 ++++++++++++++----------
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c     |  5 ----
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  | 11 ++-----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 27 +++++------------
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c      | 18 +++++++++--
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h      |  8 ++---
 drivers/net/ethernet/intel/fm10k/fm10k_ptp.c     | 13 ++++----
 drivers/net/ethernet/intel/fm10k/fm10k_type.h    |  2 +-
 9 files changed, 62 insertions(+), 62 deletions(-)

-- 
2.1.0

