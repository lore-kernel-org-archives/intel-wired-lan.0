From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:45:40 +0000
Subject: [Intel-wired-lan] [next PATCH v3 15/15] i40evf: Update feature
 flags to reflect newly enabled features
In-Reply-To: <20160125051757.12004.45770.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051757.12004.45770.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C836@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:18 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 15/15] i40evf: Update feature flags
> to reflect newly enabled features
> 
> Recent changes should have enabled support for IPv6 based tunnels and
> support for TSO with outer UDP checksums.  As such we can update the
> feature flags to reflect that.
> 
> In addition we can clean-up the flags that aren't needed such as SCTP and
> RXCSUM since having the bits there doesn't add any value.
> 
> I also found one spot where we were setting the same flag twice.  It looks
> like it was probably a git merge error that resulted in the line being
> duplicated.  As such I have dropped it in this patch.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   23
> +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied
