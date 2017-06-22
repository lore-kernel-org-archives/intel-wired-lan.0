From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Jun 2017 18:46:54 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 9/9] i40evf: add some
 missing	includes
In-Reply-To: <20170620221701.46765-9-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
 <20170620221701.46765-9-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB95D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, June 20, 2017 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S73-V2 9/9] i40evf: add some missing
> includes
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> These includes were all being used in the driver, but weren't being directly
> included.
> 
> Since the current advised method is to directly include anything that you
> need, this implements that.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


