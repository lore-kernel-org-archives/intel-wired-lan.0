From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 19:16:29 +0000
Subject: [Intel-wired-lan] [next S97 v2 4/6] i40e: Protect access to vf
 control methods
In-Reply-To: <20181030175047.18874-4-jeffrey.t.kirsher@intel.com>
References: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
 <20181030175047.18874-4-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32903B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, October 30, 2018 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S97 v2 4/6] i40e: Protect access to vf control
> methods
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> A scenario has been found in which simultaneous addition/removal and
> modification of VF's might cause unstable behaviour, up to and including
> kernel panics.
> 
> Protect the methods that create/modify/destroy VF's by locking them
> behind an atomically set bit in PF status bitfield.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 64 +++++++++++++++++--
>  2 files changed, 60 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


