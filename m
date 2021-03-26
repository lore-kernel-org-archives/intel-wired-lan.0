From: Shannon Nelson <snelson@pensando.io>
Date: Thu, 25 Mar 2021 18:32:25 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 11/11] ixgbe: reduce
 checker warnings
In-Reply-To: <20210326003834.3886241-12-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-12-jesse.brandeburg@intel.com>
Message-ID: <955f389f-a672-52c5-39d1-e73a149b01f4@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/25/21 5:38 PM, Jesse Brandeburg wrote:
> Fix the sparse warnings in the ixgbe crypto offload code. These
> changes were made in the most conservative way (force cast)
> in order to hopefully not break the code. I suspect that the
> code might still be broken on big-endian architectures, but
> no one is complaining, so I'm just leaving it functionally
> the same.

Thanks for poking at this one.

Yeah, this is a funky one where these specific register contents are in 
BE order in niantic, as are the address array entries, but 
IXGBE_READ_REG() is defined as returning u32.? The point is that we want 
to compare the register contents directly to the array entries with no 
byteswapping.? I don't think this is broken on BE arch, but I can't 
remember if I tested it on SPARC things when I wrote this at my previous 
employer.

It might make more sense in this context to define reg as __be32 and 
then force the cast on the return from IXGBE_READ_REG().? Maybe even 
change the name of 'reg' to 'be_reg' or 'bigend' just to be obnoxiously 
clear that this is a weird register.

sln

> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Shannon Nelson <snelson@pensando.io>
> ---
> Warning Detail:
> .../ixgbe/ixgbe_ipsec.c:514:56: warning: restricted __be32 degrades to integer
> .../ixgbe/ixgbe_ipsec.c:521:48: warning: restricted __be32 degrades to integer
> .../ixgbe/ixgbe_ipsec.c:536:59: warning: restricted __be32 degrades to integer
> .../ixgbe/ixgbe_ipsec.c:546:59: warning: restricted __be32 degrades to integer
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 54d47265a7ac..e596e1a9fc75 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -511,14 +511,14 @@ static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
>   					continue;
>   
>   				reg = IXGBE_READ_REG(hw, MIPAF_ARR(3, i));
> -				if (reg == xs->id.daddr.a4)
> +				if (reg == (__force u32)xs->id.daddr.a4)
>   					return 1;
>   			}
>   		}
>   
>   		if ((bmcipval & BMCIP_MASK) == BMCIP_V4) {
>   			reg = IXGBE_READ_REG(hw, IXGBE_BMCIP(3));
> -			if (reg == xs->id.daddr.a4)
> +			if (reg == (__force u32)xs->id.daddr.a4)
>   				return 1;
>   		}
>   
> @@ -533,7 +533,7 @@ static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
>   
>   			for (j = 0; j < 4; j++) {
>   				reg = IXGBE_READ_REG(hw, MIPAF_ARR(i, j));
> -				if (reg != xs->id.daddr.a6[j])
> +				if (reg != (__force u32)xs->id.daddr.a6[j])
>   					break;
>   			}
>   			if (j == 4)   /* did we match all 4 words? */
> @@ -543,7 +543,7 @@ static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
>   		if ((bmcipval & BMCIP_MASK) == BMCIP_V6) {
>   			for (j = 0; j < 4; j++) {
>   				reg = IXGBE_READ_REG(hw, IXGBE_BMCIP(j));
> -				if (reg != xs->id.daddr.a6[j])
> +				if (reg != (__force u32)xs->id.daddr.a6[j])
>   					break;
>   			}
>   			if (j == 4)   /* did we match all 4 words? */

