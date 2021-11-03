From: Switzer, David <david.switzer@intel.com>
Date: Wed, 3 Nov 2021 22:10:55 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix display error code
 in dmesg
In-Reply-To: <20211029092601.24709-1-mateusz.palczewski@intel.com>
References: <20211029092601.24709-1-mateusz.palczewski@intel.com>
Message-ID: <MW3PR11MB47485F26E4CE6C659879EA07EB8C9@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Mateusz Palczewski
>Sent: Friday, October 29, 2021 2:26 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
>Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix display error code in dmesg
>
>From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
>
>Fix misleading display error in dmesg if tc filter return fail.
>Only i40e status error code should be converted to string, not linux error code.
>Otherwise, we return false information about the error.
>
>Fixes: 2f4b411a3d67 ("i40e: Enable cloud filters via tc-flower")
>Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
>Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

