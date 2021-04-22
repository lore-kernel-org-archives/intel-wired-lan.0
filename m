From: Switzer, David <david.switzer@intel.com>
Date: Thu, 22 Apr 2021 22:53:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 02/11] intel: remove
 checker warning
In-Reply-To: <20210326003834.3886241-3-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-3-jesse.brandeburg@intel.com>
Message-ID: <MW3PR11MB47487933E2ED16887625EB67EB469@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
>Brandeburg
>Sent: Thursday, March 25, 2021 5:38 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v2 02/11] intel: remove checker
>warning
>
>The sparse checker (C=2) found an assignment where we were mixing types when
>trying to convert from data read directly from the device NVM, to an array in CPU
>order in-memory, which unfortunately the driver tries to do in-place.
>
>This is easily solved by using the swap operation instead of an assignment, and is
>already proven in other Intel drivers to be functionally correct and the same code,
>just without a sparse warning.
>
>The change is the same in all three drivers.
>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>---
>Warning Detail:
>  CHECK   .../e1000/e1000_ethtool.c
>.../e1000/e1000_ethtool.c:516:32: warning: incorrect type in assignment
>(different base types)
>.../e1000/e1000_ethtool.c:516:32:    expected unsigned short [usertype]
>.../e1000/e1000_ethtool.c:516:32:    got restricted __le16 [usertype]
>  CHECK   .../igb/igb_ethtool.c
>.../igb/igb_ethtool.c:834:32: warning: incorrect type in assignment (different
>base types)
>.../igb/igb_ethtool.c:834:32:    expected unsigned short [usertype]
>.../igb/igb_ethtool.c:834:32:    got restricted __le16 [usertype]
>  CHECK   .../igc/igc_ethtool.c
>.../igc/igc_ethtool.c:555:32: warning: incorrect type in assignment (different base
>types)
>.../igc/igc_ethtool.c:555:32:    expected unsigned short [usertype]
>.../igc/igc_ethtool.c:555:32:    got restricted __le16 [usertype]
>---
> drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
> drivers/net/ethernet/intel/igb/igb_ethtool.c     | 2 +-
> drivers/net/ethernet/intel/igc/igc_ethtool.c     | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
 

