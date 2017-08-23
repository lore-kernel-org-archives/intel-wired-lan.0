From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 20:52:48 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 09/12] i40e:
	make	i40evf_map_rings_to_vectors void
In-Reply-To: <20170822105754.29486-10-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F369@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 22, 2017 3:58 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Williams, Mitch A <mitch.a.williams@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S78-V8 09/12] i40e: make
> i40evf_map_rings_to_vectors void
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This function cannot fail, so why is it returning a value? And why are we
> checking it? Why shouldn't we just make it void? Why is this commit message
> made up of only questions?
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


