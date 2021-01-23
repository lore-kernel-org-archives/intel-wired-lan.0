From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 23 Jan 2021 00:24:46 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 06/11] ice: remove
 redundant checks in ice_change_mtu
In-Reply-To: <20210118151318.12324-7-maciej.fijalkowski@intel.com>
References: <20210118151318.12324-1-maciej.fijalkowski@intel.com>
 <20210118151318.12324-7-maciej.fijalkowski@intel.com>
Message-ID: <CO1PR11MB5105166702FEA3D49B9D867BFABF9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Fijalkowski
Sent: Monday, January 18, 2021 7:13 AM
To: intel-wired-lan@lists.osuosl.org
Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
Subject: [Intel-wired-lan] [PATCH v3 net-next 06/11] ice: remove redundant checks in ice_change_mtu

dev_validate_mtu checks that mtu value specified by user is not less than min mtu and not greater than max allowed mtu. It is being done before calling the ndo_change_mtu exposed by driver, so remove these redundant checks in ice_change_mtu.

Reviewed-by: Bj?rn T?pel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 9 ---------
 1 file changed, 9 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel
