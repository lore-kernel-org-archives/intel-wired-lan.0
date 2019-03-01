From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:50:14 +0000
Subject: [Intel-wired-lan] [PATCH S15 06/14] ice: Add missing case in
 print_link_msg for printing flow control
In-Reply-To: <20190219230414.25627-7-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3675D1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 06/14] ice: Add missing case in
> print_link_msg for printing flow control
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we aren't checking for the ICE_FC_NONE case for the current flow
> control mode. This is causing "Unknown" to be printed for the current flow
> control method if flow control is disabled. Fix this by adding the case for
> ICE_FC_NONE to print "None".
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


