From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 29 Jan 2021 17:41:25 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Improve MSI-X fallback
 logic
In-Reply-To: <20210127002217.18392-1-anthony.l.nguyen@intel.com>
References: <20210127002217.18392-1-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51059710C0C6FE140D3C35EAFAB99@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony Nguyen
Sent: Tuesday, January 26, 2021 4:22 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH net-next] ice: Improve MSI-X fallback logic

Currently if the driver is unable to get all the MSI-X vectors it wants, it falls back to the minimum configuration which equates to a single Tx/Rx traffic queue pair. Instead of using the minimum configuration, if given more vectors than the minimum, utilize those vectors for additional traffic queues after accounting for other interrupts.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 40 ++++++++++++++---------
 1 file changed, 25 insertions(+), 15 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


