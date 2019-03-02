From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:24:59 +0000
Subject: [Intel-wired-lan] [next PATCH S3 7/9] i40e: remove out-of-range
 comparisions in i40e_validate_cloud_filter
In-Reply-To: <20190228175255.54754-7-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
 <20190228175255.54754-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367721@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, February 28, 2019 9:53 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S3 7/9] i40e: remove out-of-range
> comparisions in i40e_validate_cloud_filter
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The function i40e_validate_cloud_filter checks that the destination and
> source port numbers are valid by attempting to ensure that the number is
> non-zero and no larger than 0xFFFF. However, the types for the dst_port and
> src_port variable are __be16 which by definition cannot be larger than
> 0xFFFF
> 
> Since these values cannot be larger than 2 bytes, the check to see if they
> exceed 0xFFFF is meaningless.
> 
> One might consider these checks as some sort of defensive coding, in case
> the type was later changed. However, these checks also byte-swap the value
> before comparision using be16_to_cpu, which will truncate the values to
> 16bits anyways. Additionally, changing the type would require updating the
> opcodes to support new data layout of these virtchnl commands.
> 
> Remove the check to silence the -Wtype-limits warning that was added to
> GCC 8.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


