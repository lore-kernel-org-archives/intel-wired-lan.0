From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 11 Aug 2021 05:27:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 05/12] ice: manage VSI
 antispoof and destination override
In-Reply-To: <20210625024501.6126-6-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-6-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554334B43458B06603EDF339CF89@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Friday, June 25, 2021 8:15 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v3 05/12] ice: manage VSI antispoof
>and destination override
>
>Implement functions to make setting VSI security config easier.
>Main function ice_update_security fills security section field and checks
>against error in updating VSI. Rest functions are responsible for correct filling
>config according to user esceptations.
>
>This helper is needed because destination override is located in this section.
>Driver has to set this bit to allow sttering Tx packet on VSI based on value in Tx
>descriptors.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_lib.c | 61 ++++++++++++++++++++++++
>drivers/net/ethernet/intel/ice/ice_lib.h | 11 +++++
> 2 files changed, 72 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
