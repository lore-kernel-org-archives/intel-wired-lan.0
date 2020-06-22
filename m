From: Magnus Karlsson <magnus.karlsson@intel.com>
Date: Mon, 22 Jun 2020 15:21:21 +0200
Subject: [Intel-wired-lan] [PATCH net-next 0/2] i40e: improve AF_XDP
 performance
Message-ID: <1592832083-23249-1-git-send-email-magnus.karlsson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This small series improves AF_XDP performance for the i40e NIC. The
first patch optimizes the Tx completion path for AF_XDP and the second
one removes a division in the data path for the normal SKB path, XDP
as well as AF_XDP. Overall, the throughput of the l2fwd application in
xpdsock improves with around 4% on my machine.

This patch has been applied against commit 29a720c1042f ("Merge branch
'Marvell-mvpp2-improvements'")

Thanks: Magnus

Magnus Karlsson (2):
  i40e: optimize AF_XDP Tx completion path
  i40e: eliminate division in napi_poll data path

 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 15 +++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 34 ++++++++++++++++-------------
 3 files changed, 31 insertions(+), 19 deletions(-)

--
2.7.4
