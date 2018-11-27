From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 27 Nov 2018 21:42:08 +0000
Subject: [Intel-wired-lan] [PATCH v2] i40e: fix kerneldoc for xsk methods
In-Reply-To: <20181127173536.7501-1-jeffrey.t.kirsher@intel.com>
References: <20181127173536.7501-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32BF68@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, November 27, 2018 9:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] i40e: fix kerneldoc for xsk methods
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> One method, xsk_umem_setup, had an incorrect kernel doc description,
> which has been corrected.
> 
> Also fixes small typos found in the comments.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
> v2: fixed patch corruption possibly caused by internal mail server
> 
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


