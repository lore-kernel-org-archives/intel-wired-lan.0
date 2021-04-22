From: Switzer, David <david.switzer@intel.com>
Date: Thu, 22 Apr 2021 22:10:16 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 06/11] igb: fix assignment
 on big endian machines
In-Reply-To: <20210326003834.3886241-7-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-7-jesse.brandeburg@intel.com>
Message-ID: <MW3PR11MB4748D6FE8BF6FB550555D1DFEB469@MW3PR11MB4748.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v2 06/11] igb: fix assignment on big
>endian machines
>
>The igb driver was trying hard to be sparse correct, but somehow ended up
>converting a variable into little endian order and then tries to OR something with
>it.
>
>A much plainer way of doing things is to leave all variables and OR operations in
>CPU (non-endian) mode, and then convert to little endian only once, which is
>what this change does.
>
>This probably fixes a bug that might have been seen only on big endian systems.
>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>---
>Warning Detail:
>.../igb/igb_main.c:6286:23: warning: incorrect type in assignment (different base
>types)
>.../igb/igb_main.c:6286:23:    expected unsigned int [usertype] olinfo_status
>.../igb/igb_main.c:6286:23:    got restricted __le32 [usertype]
>.../igb/igb_main.c:6291:37: warning: incorrect type in assignment (different base
>types)
>.../igb/igb_main.c:6291:37:    expected restricted __le32 [usertype] olinfo_status
>.../igb/igb_main.c:6291:37:    got unsigned int [assigned] [usertype] olinfo_status
>---
> drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
