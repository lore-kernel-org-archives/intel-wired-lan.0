From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Dec 2017 11:00:18 -0800
Subject: [Intel-wired-lan] [PATCH 0/6] recent fm10k VLAN fixes
Message-ID: <20171201190024.5547-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series contains recent fixes to fm10k, mostly related to VLAN
handling.

Jacob Keller (3):
  fm10k: cleanup unnecessary parenthesis in fm10k_iov.c
  fm10k: stop adding VLAN 0 to the VLAN table
  fm10k: don't assume VLAN 1 is enabled

Ngai-Mint Kwan (3):
  fm10k: fix "failed to kill vid" message for VF
  fm10k: correct typo in fm10k_pf.c
  fm10k: clarify action when updating the VLAN table

 drivers/net/ethernet/intel/fm10k/fm10k_iov.c    |  4 ++--
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 29 +++++++++++++++----------
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c     |  2 +-
 3 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.15.0

