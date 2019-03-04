From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 4 Mar 2019 18:43:33 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 15/17] ice: Restore VLAN switch
 rule if port VLAN existed before
In-Reply-To: <20190227003523.28733-16-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367895@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S13 v2 15/17] ice: Restore VLAN switch rule
> if port VLAN existed before
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> The VLAN rule is lost when VM starts or the AVF driver (iavf.ko) is reloaded.
> So it is necessary to add this rule again.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


