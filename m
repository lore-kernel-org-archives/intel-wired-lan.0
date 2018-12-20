From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:38:06 +0000
Subject: [Intel-wired-lan] [PATCH S10 07/15] ice: Add ethtool private
 flag to make forcing link down optional
In-Reply-To: <20181219180334.1104-8-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A35@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 07/15] ice: Add ethtool private flag to
> make forcing link down optional
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Add new infrastructure for implementing ethtool private flags using the
> existing pf->flags bitmap to store them, and add the link-down-on-close
> ethtool private flag to optionally bring down the PHY link when the interface
> is administratively downed.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 86
> ++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c    | 14 +++--
>  3 files changed, 95 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


