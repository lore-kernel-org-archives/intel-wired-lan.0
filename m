From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 1 Jun 2022 06:36:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: remove VLAN
 representor specific ops
In-Reply-To: <20220425062756.14987-3-michal.swiatkowski@linux.intel.com>
References: <20220425062756.14987-1-michal.swiatkowski@linux.intel.com>
 <20220425062756.14987-3-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554E05C162DCA5853A78ACE9CDF9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Monday, April 25, 2022 11:58 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Wilczynski, Michal <michal.wilczynski@intel.com>
>Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: remove VLAN representor
>specific ops
>
>As in switchdev mode VF VLAN caps will not be set there is no need to have
>specific VLAN ops for representor that only returns not supported error.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_virtchnl.c | 44 ++-----------------
> 1 file changed, 4 insertions(+), 40 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
