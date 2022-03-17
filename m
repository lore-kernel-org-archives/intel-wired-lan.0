From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 17 Mar 2022 19:36:26 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 0/3] ice: xsk: various fixes
Message-ID: <20220317183629.340350-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

We were solving issues around AF_XDP busy poll's not-so-usual scenarios,
such as very big busy poll budgets applied to very small HW rings. This
set carries the things that were found during that work that apply to
net tree.

One thing that was fixed for all in-tree ZC drivers was missing on ice
side all the time - it's about syncing RCU before destroying XDP
resources. Next one fixes the bit that is checked in ice_xsk_wakeup and
third one avoids false setting of DD bits on Tx descriptors.

Thanks!

Maciej Fijalkowski (3):
  ice: synchronize_rcu() when terminating rings
  ice: xsk: fix VSI state check in ice_xsk_wakeup()
  ice: clear cmd_type_offset_bsz for TX rings

 drivers/net/ethernet/intel/ice/ice.h      | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.27.0

