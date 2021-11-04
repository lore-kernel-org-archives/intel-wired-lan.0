From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Thu, 4 Nov 2021 22:37:23 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/5] ixgbevf: Improve error
 handling in mailbox
In-Reply-To: <20210630081532.3069914-3-radoslawx.tyl@intel.com>
References: <20210630081532.3069914-1-radoslawx.tyl@intel.com>
 <20210630081532.3069914-3-radoslawx.tyl@intel.com>
Message-ID: <MN2PR11MB4224FAD77329C20834B807FC828D9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tyl, RadoslawX
> Sent: Wednesday, June 30, 2021 1:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tyl, RadoslawX <radoslawx.tyl@intel.com>; Skajewski, PiotrX
> <piotrx.skajewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 2/5] ixgbevf: Improve error handling in
> mailbox
> 
> Add new handling for error codes:
>  IXGBE_ERR_CONFIG - ixgbe_mbx_operations is not correctly set
> IXGBE_ERR_TIMEOUT - mailbox operation, e.g. poll for message, timeout
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h |  3 +++
>  drivers/net/ethernet/intel/ixgbevf/mbx.c     | 14 ++++++++++----
>  drivers/net/ethernet/intel/ixgbevf/mbx.h     |  1 -
>  3 files changed, 13 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


