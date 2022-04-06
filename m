From: Olivier Matz <olivier.matz@6wind.com>
Date: Wed,  6 Apr 2022 11:52:50 +0200
Subject: [Intel-wired-lan] [PATCH net v2 0/2] ixgbe: fix promiscuous mode on
 VF
Message-ID: <20220406095252.22338-1-olivier.matz@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These 2 patches fix issues related to the promiscuous mode on VF.

Comments are welcome,
Olivier

Cc: stable at vger.kernel.org
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Changes since v1:
- resend with CC intel-wired-lan
- remove CC Hiroshi Shimamoto (address does not exist anymore)

Olivier Matz (2):
  ixgbe: fix bcast packets Rx on VF after promisc removal
  ixgbe: fix unexpected VLAN Rx in promisc mode on VF

 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.30.2

