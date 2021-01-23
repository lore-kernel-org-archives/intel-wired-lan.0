From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 23 Jan 2021 01:16:42 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 10/11] ice: store the
 result of ice_rx_offset() onto ice_ring
In-Reply-To: <20210118151318.12324-11-maciej.fijalkowski@intel.com>
References: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
 <20210118151318.12324-11-maciej.fijalkowski@intel.com>
Message-ID: <CO1PR11MB51056372C125FC21F669DE4AFABF9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Fijalkowski
Sent: Monday, January 18, 2021 7:13 AM
To: intel-wired-lan@lists.osuosl.org
Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
Subject: [Intel-wired-lan] [PATCH v3 net-next 10/11] ice: store the result of ice_rx_offset() onto ice_ring

Output of ice_rx_offset() is based on ethtool's priv flag setting, which when changed, causes PF reset (disables napi, frees irqs, loads different Rx mem model, etc.). This means that within napi its result is constant and there is no reason to call it per each processed frame.

Add new 'rx_offset' field to ice_ring that is meant to hold the
ice_rx_offset() result and use it within ice_clean_rx_irq().
Furthermore, use it within ice_alloc_mapped_page().

Reviewed-by: Bj?rn T?pel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 43 ++++++++++++-----------  drivers/net/ethernet/intel/ice/ice_txrx.h |  1 +
 2 files changed, 23 insertions(+), 21 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


