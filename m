From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Jun 2017 18:27:08 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 4/9] i40e: fix up 32
	bit	timespec references
In-Reply-To: <20170620221701.46765-4-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
 <20170620221701.46765-4-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB916@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S73-V2 4/9] i40e: fix up 32 bit
> timespec references
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> As it turns out there was only a small set of errors on 32 bit, and we just
> needed to be using the right calls for dealing with timespec64 variables.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


