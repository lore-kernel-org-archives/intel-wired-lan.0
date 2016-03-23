From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Mar 2016 16:30:29 +0000
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e/i40evf: Fix TSO
 checksum pseudo-header adjustment
In-Reply-To: <20160318230647.14801.24078.stgit@localhost.localdomain>
References: <20160318230425.14801.87895.stgit@localhost.localdomain>
 <20160318230647.14801.24078.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99F02D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, March 18, 2016 4:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 1/2] i40e/i40evf: Fix TSO checksum
> pseudo-header adjustment
> 
> With IPv4 and IPv6 now using the same format for checksums based on the
> length of the frame we need to update the i40e and i40evf drivers so that
> they correctly account for lengths greater than or equal to 64K.
> 
> With this patch the driver should now correctly update checksums for frames
> up to 16776960 in length which should be more than large enough for all
> possible TSO frames in the near future.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   11 ++++-------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   11 ++++-------
>  2 files changed, 8 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
TSO works correctly
