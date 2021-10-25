From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Mon, 25 Oct 2021 05:16:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for
 changing MTU on PR in switchdev mode
In-Reply-To: <20211018113032.76288-1-marcin.szycik@intel.com>
References: <20211018113032.76288-1-marcin.szycik@intel.com>
Message-ID: <MW3PR11MB4554671AAC8A638E11EEFBF19C839@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Monday, October 18, 2021 5:01 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for changing MTU
>on PR in switchdev mode
>
>This change adds support for changing MTU on port representor in switchdev
>mode, by setting the min/max MTU values on port representor netdev. Before
>it was possible to change the MTU only in a limited, default range (68-1500).
>
>Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_repr.c | 3 +++
> 1 file changed, 3 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
