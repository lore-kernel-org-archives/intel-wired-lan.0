From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 17 Oct 2016 10:25:05 -0700
Subject: [Intel-wired-lan] [PATCH V2 RFC 0/2] ixgbe: ixgbe_atr() bug fixes
Message-ID: <cover.1476724638.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Two bug fixes:
- ixgbe_atr() should check for protocol == udp in the
  skb->encapsulation case (instead of !=)
- ixgbe_atr() should make sure the non-paged data has the
  needed network/transport header for computing l4_proto.

Sowmini Varadhan (2):
  ixgbe: ixgbe_atr() should access udp_hdr(skb) only for UDP packets
  ixgbe: ixgbe_atr() compute l4_proto only if non-paged data has
    network/transport headers

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

