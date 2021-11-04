From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Thu, 4 Nov 2021 22:36:48 +0000
Subject: [Intel-wired-lan] [PATCH v2 4/5] ixgbevf: Mailbox improvements
In-Reply-To: <20210630081532.3069914-5-radoslawx.tyl@intel.com>
References: <20210630081532.3069914-1-radoslawx.tyl@intel.com>
 <20210630081532.3069914-5-radoslawx.tyl@intel.com>
Message-ID: <MN2PR11MB4224C977A7BA9C351D9B8AE6828D9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 4/5] ixgbevf: Mailbox improvements
> 
> Improve reliability of the mailbox communication and remove its potential
> flaws that may lead to the undefined or faulty behavior.
> 
> Recently some users reported issues on ESX with 10G Intel NICs which were
> found to be caused by incorrect implementation of the PF-VF mailbox
> communication.
> 
> Technical investigation highlighted areas to improve in the communication
> between PF or VF that wants to send the message (sender) and the other
> part which receives the message (receiver):
> 
>  - Locking the mailbox when the sender wants to send a message
>  - Releasing the mailbox when the communication ends
>  - Returning the result of the mailbox message execution
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h |   1 +
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c   |   8 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |   5 +
>  drivers/net/ethernet/intel/ixgbevf/mbx.c     | 313 +++++++++++++++----
>  drivers/net/ethernet/intel/ixgbevf/vf.c      |  17 +-
>  drivers/net/ethernet/intel/ixgbevf/vf.h      |   5 +-
>  6 files changed, 265 insertions(+), 84 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


