From: Magnus Karlsson <magnus.karlsson@intel.com>
Date: Tue, 23 Jun 2020 11:44:15 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 0/3] i40e: improve AF_XDP
 performance
Message-ID: <1592905458-850-1-git-send-email-magnus.karlsson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This small series improves AF_XDP performance for the i40e NIC. The
first patch optimizes the Tx completion path for AF_XDP. The second
one removes a division in the data path for the normal SKB path, XDP
as well as AF_XDP. Finally, the third one moves the test of a full Tx
ring to outside the send loop. Overall, the throughput of the l2fwd
application in xpdsock improves with around 8% on my machine.

v1->v2:
* Removed unnecessary variables in i40e_clean_xdp_tx_irq [Sridhar]
* Added one further optimization to Tx path in a new patch [Sridhar]
* Fixed two API documentation warnings with make W=1

This patch has been applied against commit 8af7b4525acf ("Merge branch
'net-atlantic-additional-A2-features'")

Thanks: Magnus

Magnus Karlsson (3):
  i40e: optimize AF_XDP Tx completion path
  i40e: eliminate division in napi_poll data path
  i40e: move check of full Tx ring to outside of send loop

 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 17 ++++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 57 +++++++++++++----------------
 drivers/net/ethernet/intel/i40e/i40e_xsk.h  |  3 +-
 4 files changed, 39 insertions(+), 39 deletions(-)

--
2.7.4
