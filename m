From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 24 Sep 2021 08:39:03 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Allow to enable/disable
 hw-tc-offload on PF
In-Reply-To: <20210914084315.25585-1-wojciech.drewek@intel.com>
References: <20210914084315.25585-1-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB45542FF7A2C9683F66EEFE869CA49@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Tuesday, September 14, 2021 2:13 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Allow to enable/disable hw-tc-
>offload on PF
>
>Set NETIF_F_HW_TC in netdev->hw_features so that user could
>enable/disable hw-tc-offload feature.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
> 1 file changed, 3 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
