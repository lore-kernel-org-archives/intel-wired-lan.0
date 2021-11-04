From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Thu, 4 Nov 2021 22:37:44 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/5] ixgbevf: Rename MSGTYPE to
 SUCCESS and FAILURE
In-Reply-To: <20210630081532.3069914-2-radoslawx.tyl@intel.com>
References: <20210630081532.3069914-1-radoslawx.tyl@intel.com>
 <20210630081532.3069914-2-radoslawx.tyl@intel.com>
Message-ID: <MN2PR11MB42245FA2AB860F5A465CCF38828D9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 1/5] ixgbevf: Rename MSGTYPE to
> SUCCESS and FAILURE
> 
> There is name similarity within IXGBE_VT_MSGTYPE_ACK and
> PFMAILBOX.ACK / VFMAILBOX.ACK. MSGTYPE macros are renamed to
> SUCCESS and FAILURE because they are not specified in datasheet and now
> will be easily distinguishable.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/mbx.h   | 17 +++++++-----
>  drivers/net/ethernet/intel/ixgbevf/vf.c    | 31 +++++++++++-----------
>  3 files changed, 27 insertions(+), 23 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


