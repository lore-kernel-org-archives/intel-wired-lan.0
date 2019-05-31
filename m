From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 May 2019 17:56:43 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Do not check VF state in
 i40e_ndo_get_vf_config
In-Reply-To: <20190523234533.48418-1-lihong.yang@intel.com>
References: <20190523234533.48418-1-lihong.yang@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DD57F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Lihong Yang
> Sent: Thursday, May 23, 2019 4:46 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Do not check VF state in
> i40e_ndo_get_vf_config
> 
> The VF configuration returned in i40e_ndo_get_vf_config is already stored
> by the PF. There is no dependency on any specific state of the VF to return
> the configuration.
> Drop the check against I40E_VF_STATE_INIT since it is not needed.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


