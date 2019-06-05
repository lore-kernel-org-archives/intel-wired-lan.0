From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 5 Jun 2019 22:11:55 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Check and set the PF driver
 state first in i40e_ndo_set_vf_mac
In-Reply-To: <20190529230642.87106-1-lihong.yang@intel.com>
References: <20190529230642.87106-1-lihong.yang@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DDAF0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Lihong Yang
> Sent: Wednesday, May 29, 2019 4:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Check and set the PF driver state first
> in i40e_ndo_set_vf_mac
> 
> The PF driver state flag __I40E_VIRTCHNL_OP_PENDING needs to be
> checked and set at the beginning of i40e_ndo_set_vf_mac. Otherwise, if
> there are error conditions before it, the flag will be cleared unexpectedly by
> this function to cause potential race conditions.
> Hence move the check to the top of this function.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


