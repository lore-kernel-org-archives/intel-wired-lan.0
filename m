From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:33:19 +0000
Subject: [Intel-wired-lan] [PATCH S12 05/14] ice : Ensure only valid
 bits are set in ice_aq_set_phy_cfg
In-Reply-To: <20190208205101.12078-6-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367027@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S12 05/14] ice : Ensure only valid bits are
> set in ice_aq_set_phy_cfg
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> In the ice_aq_set_phy_cfg AQ command, the 16.4 bit is reserved. This patch
> will make sure that this bit will never be set to 1.
> 
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  5 +++--
>  drivers/net/ethernet/intel/ice/ice_common.c     | 11 +++++++++++
>  drivers/net/ethernet/intel/ice/ice_type.h       |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


