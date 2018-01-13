From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 12 Jan 2018 17:10:13 -0800
Subject: [Intel-wired-lan] [PATCH 0/2] ixgbe: ipsec offload and sparc support
Message-ID: <1515805815-2692-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These are a couple of tweaks I found while making sure that the ipsec
offload would work on SPARC.

Shannon Nelson (2):
  ixgbe: ipsec offload for sparc
  ixgbe: use compiler constants in Rx path

 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4

