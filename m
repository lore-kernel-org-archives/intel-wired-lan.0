From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Mon, 14 Sep 2015 00:27:42 -0600
Subject: [Intel-wired-lan] [next-queue 0/8] Trivial fix-ups for Intel wired
	LAN drivers 09/10/2015
Message-ID: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains trivial fix-ups and cleanups for Intel wired LAN
drivers as of 09/10/2015:

1) Two trivial fix-ups for local object initialization and duplicate
   exit path.

2) Two cleanups for local variable and a keyword.

3) Four kernel-doc fix-ups.

Jean Sacren (8):
  e1000: clean up the useless 'continue' statement
  e1000: fix a typo in the comment
  e1000e: clean up the local variable
  i40e: fix kernel-doc argument name
  ixgbe: fix multiple kernel-doc errors
  i40e: declare rather than initialize int object
  e1000: fix kernel-doc argument being missing
  e1000: get rid of duplicate exit path

 drivers/net/ethernet/intel/e1000/e1000_hw.c   | 8 ++++----
 drivers/net/ethernet/intel/e1000/e1000_main.c | 7 ++++---
 drivers/net/ethernet/intel/e1000e/netdev.c    | 5 +----
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++------
 5 files changed, 14 insertions(+), 19 deletions(-)

