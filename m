From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:35:18 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 05/15] ice: fix set pause param
 autoneg check
In-Reply-To: <20190725085541.55104-5-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-5-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E94F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 1:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v4 05/15] ice: fix set pause param
> autoneg check
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> When ETHTOOL_GLINKSETTINGS is defined get pause param pause-
> >autoneg reports SW configured setting, however when not defined get
> pause param
> pause->autoneg reports the link status. Set pause param needs to compare
> pause->autoneg with the same source as get pause param to block the user
> from changing autoneg with the set pause param option, or the user may be
> incorrectly blocked from changing Rx|Tx pause settings.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 28 +++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


