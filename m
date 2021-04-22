From: Switzer, David <david.switzer@intel.com>
Date: Thu, 22 Apr 2021 22:09:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 07/11] igb: override two
 checker warnings
In-Reply-To: <20210326003834.3886241-8-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-8-jesse.brandeburg@intel.com>
Message-ID: <MW3PR11MB4748D8C5BADBA47BE051CF41EB469@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
>Brandeburg
>Sent: Thursday, March 25, 2021 5:39 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v2 07/11] igb: override two checker
>warnings
>
>The igb PTP code was using htons() on a constant to try to byte swap the value
>before writing it to a register. This byte swap has the consequence of triggering
>sparse conflicts between the register write which expect cpu ordered input, and
>the code which generated a big endian constant. Just override the cast to make
>sure code doesn't change but silence the warning.
>
>Can't do a __swab16 in this case because big endian systems would then write
>the wrong value.
>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>---
>Warning Detail
>  CHECK   .../igb/igb_ptp.c
>.../igb/igb_ptp.c:1137:17: warning: incorrect type in argument 1 (different base
>types)
>.../igb/igb_ptp.c:1137:17:    expected unsigned int val
>.../igb/igb_ptp.c:1137:17:    got restricted __be16 [usertype]
>.../igb/igb_ptp.c:1142:25: warning: incorrect type in argument 1 (different base
>types)
>.../igb/igb_ptp.c:1142:25:    expected unsigned int val
>.../igb/igb_ptp.c:1142:25:    got restricted __be16 [usertype]
>---
> drivers/net/ethernet/intel/igb/igb_ptp.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
