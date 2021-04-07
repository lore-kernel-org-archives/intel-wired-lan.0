From: Switzer, David <david.switzer@intel.com>
Date: Wed, 7 Apr 2021 22:57:27 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse warning: missing
 error code 'err'
In-Reply-To: <20210326184343.133396-4-arkadiusz.kubalewski@intel.com>
References: <20210326184343.133396-1-arkadiusz.kubalewski@intel.com>
 <20210326184343.133396-4-arkadiusz.kubalewski@intel.com>
Message-ID: <MW3PR11MB47483391F928BCFE93F0F7CAEB759@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Arkadiusz Kubalewski
>Sent: Friday, March 26, 2021 11:44 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>Subject: [Intel-wired-lan] [PATCH net] i40e: Fix sparse warning: missing error
>code 'err'
>
>Set proper return values inside error checking if-statements.
>
>Previously following warning was produced when compiling against sparse.
>i40e_main.c:15162 i40e_init_recovery_mode() warn: missing error code 'err'
>
>Fixes: 4ff0ee1af0169 ("i40e: Introduce recovery mode support")
>Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
