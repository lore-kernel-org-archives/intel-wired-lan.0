From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Thu, 4 Nov 2021 22:37:06 +0000
Subject: [Intel-wired-lan] [PATCH v2 3/5] ixgbevf: Add legacy suffix to
 old API mailbox functions
In-Reply-To: <20210630081532.3069914-4-radoslawx.tyl@intel.com>
References: <20210630081532.3069914-1-radoslawx.tyl@intel.com>
 <20210630081532.3069914-4-radoslawx.tyl@intel.com>
Message-ID: <MN2PR11MB4224D43B7CDCCC1DEDF6C9DC828D9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tyl, RadoslawX
> Sent: Wednesday, June 30, 2021 1:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tyl, RadoslawX <radoslawx.tyl@intel.com>; Skajewski, PiotrX
> <piotrx.skajewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 3/5] ixgbevf: Add legacy suffix to old API
> mailbox functions
> 
> Add legacy suffix to mailbox functions which should be backwards
> compatible with older PF drivers. Communication during API negotiation
> always has to be done using the earlier implementation.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/mbx.c          | 14 +++++++-------
>  3 files changed, 9 insertions(+), 9 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


