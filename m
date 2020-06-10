From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 10 Jun 2020 22:31:06 +0000
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add support for 5Gbps
 cards
In-Reply-To: <20200529200122.1471018-1-jeffrey.t.kirsher@intel.com>
References: <20200529200122.1471018-1-jeffrey.t.kirsher@intel.com>
Message-ID: <BN6PR1101MB214504E83090386BE4B190528C830@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jeff Kirsher
> Sent: Friday, May 29, 2020 1:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next-queue v2] i40e: Add support for 5Gbps cards
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Make possible for the i40e driver to bind to the new v710 for 5GBASE-T NICs.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +++
> drivers/net/ethernet/intel/i40e/i40e_devids.h | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


