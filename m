From: sven.auhagen@voleatech.de <sven.auhagen@voleatech.de>
Date: Sat, 17 Oct 2020 09:12:32 +0200
Subject: [Intel-wired-lan] [PATCH v2 0/6] igb: xdp patches followup
Message-ID: <20201017071238.95190-1-sven.auhagen@voleatech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sven Auhagen <sven.auhagen@voleatech.de>

This patch series addresses some of the comments that came back
after the igb XDP patch was accepted.
Most of it is code cleanup.
The last patch contains a fix for a tx queue timeout
that can occur when using xdp.

Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>

Change from v1:
    * Drop patch 5 as the igb_rx_frame_truesize won't match
    * Fix typo in comment
    * Add Suggested-by and Reviewed-by tags
    * Add how to avoid transmit queue timeout in xdp path
      is fixed in the commit message

Sven Auhagen (6):
  igb: XDP xmit back fix error code
  igb: take vlan double header into account
  igb: XDP extack message on error
  igb: skb add metasize for xdp
  igb: use xdp_do_flush
  igb: avoid transmit queue timeout in xdp path

 drivers/net/ethernet/intel/igb/igb.h      |  5 ++++
 drivers/net/ethernet/intel/igb/igb_main.c | 32 +++++++++++++++--------
 2 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.20.1

