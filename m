From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 18:18:44 +0000
Subject: [Intel-wired-lan] [PATCH S24 08/12] ice: Rename ethtool private
 flag for lldp
In-Reply-To: <20190723092759.3614-8-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
 <20190723092759.3614-8-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CDE3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, July 23, 2019 2:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 08/12] ice: Rename ethtool private flag
> for lldp
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The current flag name of "enable-fw-lldp" is a bit cumbersome.
> 
> Change priv-flag name to "fw-lldp-agent" with a value of on or off.  This is
> more straight-forward in meaning.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 2 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++---
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


