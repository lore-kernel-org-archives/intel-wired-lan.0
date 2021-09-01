From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 1 Sep 2021 10:41:22 +0000
Subject: [Intel-wired-lan] [next-queue v4 12/12] ice: add port
 representor ethtool ops and stats
In-Reply-To: <20210820000859.680522-13-anthony.l.nguyen@intel.com>
References: <20210820000859.680522-1-anthony.l.nguyen@intel.com>
 <20210820000859.680522-13-anthony.l.nguyen@intel.com>
Message-ID: <MW3PR11MB4554325EF24F737D6CEEE6DD9CCD9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Tony Nguyen
>Sent: Friday, August 20, 2021 5:39 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [next-queue v4 12/12] ice: add port representor
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
>In all cases, existing operations were used with minor changes which allow us
>to detect if ethtool op was called for representor. Only VF VSI stats will be
>available for representor.
>
>Implement ndo_get_stats64 for port representor. This will update VF VSI stats
>and read them.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h          | 14 +++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  5 ++
>drivers/net/ethernet/intel/ice/ice_ethtool.c  | 55 +++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_repr.c     | 33 +++++++++++
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  4 +-
>.../net/ethernet/intel/ice/ice_virtchnl_pf.h  | 13 +++++
> 6 files changed, 117 insertions(+), 7 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
