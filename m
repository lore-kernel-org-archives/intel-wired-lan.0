From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Thu, 4 Nov 2021 22:36:28 +0000
Subject: [Intel-wired-lan] [PATCH v2 5/5] ixgbevf: Add support for new
 mailbox communication between PF and VF
In-Reply-To: <20210630081532.3069914-6-radoslawx.tyl@intel.com>
References: <20210630081532.3069914-1-radoslawx.tyl@intel.com>
 <20210630081532.3069914-6-radoslawx.tyl@intel.com>
Message-ID: <MN2PR11MB42246C9063377D61829FF544828D9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 5/5] ixgbevf: Add support for new
> mailbox communication between PF and VF
> 
> Provide improved mailbox communication, between PF and VF, which is
> defined as API version 1.5.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c        |  1 +
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  9 +++++++++
>  drivers/net/ethernet/intel/ixgbevf/mbx.h          |  1 +
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 14 ++++++++++++--
>  4 files changed, 23 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


