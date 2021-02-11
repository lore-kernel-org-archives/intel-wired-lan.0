From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 11 Feb 2021 00:59:19 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix endianness
 conversions
In-Reply-To: <20210205084852.28545-1-mateusz.palczewski@intel.com>
References: <20210205084852.28545-1-mateusz.palczewski@intel.com>
Message-ID: <CO1PR11MB5105CCB57B069F3ADD9140D1FA8C9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Mateusz Palczewski
Sent: Friday, February 5, 2021 12:49 AM
To: intel-wired-lan@lists.osuosl.org
Cc: Ciosek, NorbertX <norbertx.ciosek@intel.com>
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix endianness conversions

From: Norbert Ciosek <norbertx.ciosek@intel.com>

Fixes the following sparse warnings:
i40e_main.c:5953:32: warning: cast from restricted __le16
i40e_main.c:8008:29: warning: incorrect type in assignment (different base types)
i40e_main.c:8008:29:    expected unsigned int [assigned] [usertype] ipa
i40e_main.c:8008:29:    got restricted __le32 [usertype]
i40e_main.c:8008:29: warning: incorrect type in assignment (different base types)
i40e_main.c:8008:29:    expected unsigned int [assigned] [usertype] ipa
i40e_main.c:8008:29:    got restricted __le32 [usertype]
i40e_txrx.c:1950:59: warning: incorrect type in initializer (different base types)
i40e_txrx.c:1950:59:    expected unsigned short [usertype] vlan_tag
i40e_txrx.c:1950:59:    got restricted __le16 [usertype] l2tag1
i40e_txrx.c:1953:40: warning: cast to restricted __le16
i40e_xsk.c:448:38: warning: invalid assignment: |=
i40e_xsk.c:448:38:    left side has type restricted __le64
i40e_xsk.c:448:38:    right side has type int

Fixes: 2f4b411a3d67 ("i40e: Enable cloud filters via tc-flower")
Fixes: 2a508c64ad27 ("i40e: fix VLAN.TCI == 0 RX HW offload")
Fixes: 3106c580fb7c ("i40e: Use batched xsk Tx interfaces to increase performance")
Fixes: 8f88b3034db3 ("i40e: Add infrastructure for queue channel support")
Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  2 +-  drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


