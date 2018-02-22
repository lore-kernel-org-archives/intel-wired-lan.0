From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 22 Feb 2018 11:09:54 -0800
Subject: [Intel-wired-lan] [PATCH next-queue 0/3] ixgbe: ipsec fixups
Message-ID: <1519326597-7679-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These are a couple of updates for the ixgbe IPsec offload support.

Shannon Nelson (3):
  ixgbe: check for 128-bit authentication
  ixgbe: fix ipsec trailer length
  ixgbe: remove unneeded ipsec state free callback

 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 53 +++++++++++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |  1 +
 2 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.7.4

