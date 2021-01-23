From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 23 Jan 2021 01:13:25 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 05/11] ice: move skb
 pointer from rx_buf to rx_ring
In-Reply-To: <20210118151318.12324-6-maciej.fijalkowski@intel.com>
References: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
 <20210118151318.12324-6-maciej.fijalkowski@intel.com>
Message-ID: <CO1PR11MB51051BEF0A7237F13BB58575FABF9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Fijalkowski
Sent: Monday, January 18, 2021 7:13 AM
To: intel-wired-lan@lists.osuosl.org
Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
Subject: [Intel-wired-lan] [PATCH v3 net-next 05/11] ice: move skb pointer from rx_buf to rx_ring

Similar thing has been done in i40e, as there is no real need for having the sk_buff pointer in each rx_buf. Non-eop frames can be simply handled on that pointer moved upwards to rx_ring.

Reviewed-by: Bj?rn T?pel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 30 ++++++++++-------------  drivers/net/ethernet/intel/ice/ice_txrx.h |  2 +-
 2 files changed, 14 insertions(+), 18 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


