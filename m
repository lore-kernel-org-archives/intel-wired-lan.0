From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 6 Aug 2021 10:46:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 12/12] ice: add port
 representor ethtool ops and stats
In-Reply-To: <20210625024501.6126-13-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-13-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554699BF83C0A9F725212F99CF39@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 12/12] ice: add port representor
>ethtool ops and stats
>
>From: Wojciech Drewek <wojciech.drewek@intel.com>
>
>Introduce the following ethtool operations for VF's representor:
>	-get_drvinfo
>	-get_strings
>	-get_ethtool_stats
>	-get_sset_count
>	-get_link
>
>In all cases, exsisting operations were used with minor changes which allow us
>to detect if ethtool op was called for representor. Only VF VSI stats will be
>available for representor.
>
>Implement ndo_get_stats64 for port representor. This will update VF VSI stats
>and read them.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h         | 14 +++++++++
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 32 ++++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_repr.c    | 29 ++++++++++++++++++
> 3 files changed, 72 insertions(+), 3 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
