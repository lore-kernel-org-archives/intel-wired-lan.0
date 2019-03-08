From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:50:55 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 09/17] ice: Enable LAN_EN for
 the right recipes
In-Reply-To: <20190227003523.28733-10-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368F68@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 09/17] ice: Enable LAN_EN for the
> right recipes
> 
> From: Yashaswini Raghuram Prathivadi Bhayankaram
> <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
> 
> In VEB mode, enable LAN_EN bit in the action fields for filter rules
> corresponding to the right recipes.
> 
> Signed-off-by: Yashaswini Raghuram Prathivadi Bhayankaram
> <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 29 ++++++++++++++++++++--
> -------
>  1 file changed, 20 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


