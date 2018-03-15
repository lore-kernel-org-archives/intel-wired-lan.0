From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 15 Mar 2018 14:23:19 -0700
Subject: [Intel-wired-lan] [next-queue 0/4] ixgbe: Enable tso and checksum
 offload with ipsec
Message-ID: <1521149003-1433-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset fixes up the bits for supporting TSO and checksum
offload in conjunction with IPsec offload.  This brings the
throughput of a simple iperf test back up to nearly line rate.

Shannon Nelson (4):
  ixgbe: no need for ipsec csum feature check
  ixgbe: remove unneeded ipsec test in Tx path
  ixgbe: no need for esp trailer if gso
  ixgbe: enable tso with ipsec offload

 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 45 +++++++++++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 30 ++++++++---------
 2 files changed, 42 insertions(+), 33 deletions(-)

-- 
2.7.4

