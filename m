From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Feb 2019 21:52:44 +0000
Subject: [Intel-wired-lan] [PATCH S11 14/16] ice: use absolute vector ID
 for VFs
In-Reply-To: <20190208205043.11975-15-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3669B6@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S11 14/16] ice: use absolute vector ID for
> VFs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When the PF driver sets up the VF MSI-X vector allocation, it needs to use
> the hardware absolute vector ID, not the per-PF vector ID. Without this
> change we see (apparent) TX hangs when using VFs on multiple PFs.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


