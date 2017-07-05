From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 5 Jul 2017 15:08:29 -0700
Subject: [Intel-wired-lan] [next PATCH S75-V2 06/12] i40e: prevent
 snprintf format specifier truncation
In-Reply-To: <20170629083643.82018-6-alice.michael@intel.com>
References: <20170629083643.82018-1-alice.michael@intel.com>
 <20170629083643.82018-6-alice.michael@intel.com>
Message-ID: <c20f02b1-85fc-207d-6f7c-a5ebd8b77747@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2017 1:36 AM, Alice Michael wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Increase the size of the prefix buffer so that it can hold enough
> characters for every possible input. Although 20 is enough for all
> expected inputs, it is possible for the values to be larger than
> expected, resulting in a possibly truncated string.
> 
> New versions of GCC starting at 7 now include warnings to prevent
> truncation unless you handle the return code. At most 27 bytes can be
> written here, so lets just increase the buffer size even if for all
> expected hw->bus.* values we only needed 20.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_common.c   | 4 ++--
>   drivers/net/ethernet/intel/i40evf/i40e_common.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 5c36a18..69d5cd8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -328,9 +328,9 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
>   			len = buf_len;
>   		/* write the full 16-byte chunks */
>   		if (hw->debug_mask & mask) {
> -			char prefix[20];
> +			char prefix[27];
>   
> -			snprintf(prefix, 20,
> +			snprintf(prefix, 27,

You might use sizeof(prefix) here rather than hoping that the number 
stays in sync with the actual declaration.

>   				 "i40e %02x:%02x.%x: \t0x",
>   				 hw->bus.bus_id,
>   				 hw->bus.device,
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
> index 1dd1938..d0fc662 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
> @@ -333,9 +333,9 @@ void i40evf_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
>   			len = buf_len;
>   		/* write the full 16-byte chunks */
>   		if (hw->debug_mask & mask) {
> -			char prefix[20];
> +			char prefix[27];
>   
> -			snprintf(prefix, 20,
> +			snprintf(prefix, 27,

Same comment.

sln

>   				 "i40evf %02x:%02x.%x: \t0x",
>   				 hw->bus.bus_id,
>   				 hw->bus.device,
> 
