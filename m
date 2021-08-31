From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Tue, 31 Aug 2021 20:45:00 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-next 2/4] ice: Implement
 functions for reading and setting GPIO pins
In-Reply-To: <20210817110918.1937113-3-maciej.machnikowski@intel.com>
References: <20210817110918.1937113-1-maciej.machnikowski@intel.com>
 <20210817110918.1937113-3-maciej.machnikowski@intel.com>
Message-ID: <CO1PR11MB5028CA2295732DC444284E4AA0CC9@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Machnikowski
> Sent: Tuesday, August 17, 2021 4:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-next 2/4] ice: Implement functions for reading and setting GPIO pins
>
> Implement ice_aq_get_gpio and ice_aq_set_gpio for reading and changing the state of GPIO pins described in the topology.
>
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 13 +++++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 58 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  6 ++
>  3 files changed, 77 insertions(+)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
