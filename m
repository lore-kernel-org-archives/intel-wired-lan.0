From: Switzer, David <david.switzer@intel.com>
Date: Mon, 3 May 2021 20:51:00 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix the restart
 auto-negotiation after FEC modified
In-Reply-To: <20210413141940.3456-1-mateusz.palczewski@intel.com>
References: <20210413141940.3456-1-mateusz.palczewski@intel.com>
Message-ID: <MW3PR11MB474809C402E7B8363FFCC36AEB5B9@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Mateusz Palczewski
>Sent: Tuesday, April 13, 2021 7:20 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Gawin, JaroslawX <jaroslawx.gawin@intel.com>; Palczewski, Mateusz
><mateusz.palczewski@intel.com>
>Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix the restart auto-negotiation
>after FEC modified
>
>From: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
>
>When FEC mode was changed the link didn't know it because the link was not
>reset and new parameters were not negotiated.
>Set a flag 'I40E_AQ_PHY_ENABLE_ATOMIC_LINK' in 'abilities'
>to restart the link and make it run with the new settings.
>
>Fixes: 1d96340196f1 ("i40e: Add support FEC configuration for Fortville
>25G")
>Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
>Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
>---
> v2: Fixed fixes tag
>---
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com> 

