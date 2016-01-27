From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 16:03:32 +0000
Subject: [Intel-wired-lan] [next PATCH v3 02/15] i40e/i40evf: Use u64
 values instead of casting them in TSO function
In-Reply-To: <20160125051620.12004.2775.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051620.12004.2775.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C741@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:16 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 02/15] i40e/i40evf: Use u64 values
> instead of casting them in TSO function
> 
> Instead of casing u32 values to u64 it makes more sense to just start out with
> u64 values in the first place.  This way we don't need to create a mess with all
> of the casts needed to populate a 64b value.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    9 ++++-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    9 ++++-----
>  2 files changed, 8 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code change properly applied
