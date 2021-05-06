From: Switzer, David <david.switzer@intel.com>
Date: Thu, 6 May 2021 14:17:54 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix PHY type identifiers
 for 2.5G and 5G adapters
In-Reply-To: <20210413144307.3616-1-mateusz.palczewski@intel.com>
References: <20210413144307.3616-1-mateusz.palczewski@intel.com>
Message-ID: <MW3PR11MB47480D31C46954B159445C67EB589@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Mateusz Palczewski
>Sent: Tuesday, April 13, 2021 7:43 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Lukwinski, Dawid
><dawid.lukwinski@intel.com>
>Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix PHY type identifiers for 2.5G
>and 5G adapters
>
>Unlike other supported adapters, 2.5G and 5G use different PHY type identifiers
>for reading/writing PHY settings and for reading link status. This commit
>introduces separate PHY identifiers for these two operation types.
>
>Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
>Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
>Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>---
> v3: Added missing changes and fixed fixes tag
> v2: Added missing changes in i40e_ethtool.c file
>--
> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 6 ++++--
> drivers/net/ethernet/intel/i40e/i40e_common.c     | 4 ++--
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c    | 4 ++--
> drivers/net/ethernet/intel/i40e/i40e_type.h       | 7 ++-----
> 4 files changed, 10 insertions(+), 11 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
 

