From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Mar 2018 23:30:32 +0000
Subject: [Intel-wired-lan] [PATCH S88 4/8] i40e: add doxygen comment for
 new mode parameter
In-Reply-To: <20180314181918.21582-4-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
 <20180314181918.21582-4-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C2DD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, March 14, 2018 11:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S88 4/8] i40e: add doxygen comment for
> new mode parameter
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A recent patch updated the signature for i40e_aq_set_switch_config() to
> add a new parameter 'mode'. It forgot to document the parameter in the
> doxygen function header comment. Add the parameter to the function
> description now.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


