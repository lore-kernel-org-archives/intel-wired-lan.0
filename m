From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Dec 2015 18:35:21 +0000
Subject: [Intel-wired-lan] [next PATCH S23 02/13] i40e: remove
	forever	unused ID
In-Reply-To: <1449705033-4968-3-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-3-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96EF5A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 02/13] i40e: remove forever
> unused ID
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Somehow an ID that has never been productized is in the code.  There are no
> plans to use it, so just get rid of it.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I59117d48ea9ee0360b0fe33833ac8092f8a24b4c
> ---
> Testing Hints: make sure the code is all gone that refers to it.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_devids.h   | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 1 -
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 -
> drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 -
>  5 files changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
