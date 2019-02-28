From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:32:36 +0000
Subject: [Intel-wired-lan] [PATCH S12 02/14] ice: Fix issue with VF
 reset and multiple VFs support on PFs
In-Reply-To: <20190208205101.12078-3-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367017@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S12 02/14] ice: Fix issue with VF reset and
> multiple VFs support on PFs
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch fixes issues with VF queues being disabled, and VF netdev
> network carrier being lost after reset. Basically, we need to check if VF is
> enabled, and queue configured in reset_all_vfs flow, and disable/enable
> those queues appropriately whenever the function is called after
> Global/CORER/PFR reset/rebuild/replay.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


