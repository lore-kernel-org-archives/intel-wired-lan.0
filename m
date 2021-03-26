From: Switzer, David <david.switzer@intel.com>
Date: Fri, 26 Mar 2021 23:55:03 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix inconsistent indenting
In-Reply-To: <20210217202119.228020-1-arkadiusz.kubalewski@intel.com>
References: <20210217202119.228020-1-arkadiusz.kubalewski@intel.com>
Message-ID: <MW3PR11MB47482791D33C46B87D904712EB619@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Kubalewski, Arkadiusz
>Sent: Wednesday, February 17, 2021 12:21 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>Subject: [Intel-wired-lan] [PATCH net] i40e: Fix inconsistent indenting
>
>Fixed new static analysis findings:
>"warn: inconsistent indenting" - introduced lately, reported with lkp and
>smatch build.
>
>Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based
>DCB")
>Reported-by: kernel test robot <lkp@intel.com>
>Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

