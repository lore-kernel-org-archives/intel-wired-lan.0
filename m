From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 18:17:39 +0000
Subject: [Intel-wired-lan] [PATCH S24 06/12] ice: Copy dcbx
 configuration only if mode is correct
In-Reply-To: <20190723092759.3614-6-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
 <20190723092759.3614-6-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CDC3@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S24 06/12] ice: Copy dcbx configuration
> only if mode is correct
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> In rebuild DCB desired_dcbx_cfg was copy to local_dcbx_cfg, but if DCBX
> mode is IEEE desired_dcbx_cfg is not initialized by DCBX config from FW.
> Change logic to copy config value only if mode is set to CEE.
> 
> If driver copy desired_dcbx_cfg to local_dcbx_cfg in IEEE mode there is
> problem with globr. System is frozen after two or more globr.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


