From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Dec 2015 16:58:10 +0000
Subject: [Intel-wired-lan] [next PATCH S23 10/13] i40evf: null out
	ring	pointers on free
In-Reply-To: <1449705033-4968-11-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-11-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F0F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 10/13] i40evf: null out ring
> pointers on free
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Since we check these ring pointers to make sure we don't double-allocate or
> double-free the rings, we had better null them out after we free them. In
> very rare cases this can cause a panic if the driver is removed during reset
> recovery.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ib06eb4910a3058275c8f7ec5ef7f45baa4674f96
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
