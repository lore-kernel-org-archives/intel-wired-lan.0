From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 21 Apr 2016 12:23:08 -0700
Subject: [Intel-wired-lan] [next S35 v4 4/9] i40e: Refactor receive
	routine
In-Reply-To: <1461206617-105072-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1461206617-105072-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <20160421122308.0000155d@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On Wed, 20 Apr 2016 19:43:37 -0700
Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:

> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This is part 1 of the Rx refactor series, just including
> changes to i40e.
> 
> This refactor aligns the receive routine with the one in
> ixgbe which was highly optimized.  This reduces the code
> we have to maintain and allows for (hopefully) more readable
> and maintainable RX hot path.
> 
> In order to do this:
> - consolidate the receive path into a single function that doesn't
>   use packet split but *does* use pages for Rx buffers.
> - remove the old _1buf routine
> - consolidate several routines into helper functions
> - remove ethtool control over packet split
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I5ca100721de65992aa0114f8b4bac844b84758e0
> ---
> v4: fixed return to a continue (based on feedback from Alex Duyck)
> v3: move dma sync into always used path
>     move setting of rx queue into process skb fields
> 
> v2: code was split into more reviewable chunks

Thanks Jeff for making the v4.

snip...
  
> -		/* ERR_MASK will only have valid bits if EOP set */
> -		if (unlikely(rx_error & BIT(I40E_RX_DESC_ERROR_RXE_SHIFT))) {
> +		/* ERR_MASK will only have valid bits if EOP set, and
> +		 * what we are doing here is actually checking
> +		 * I40E_RX_DESC_ERROR_RXE_SHIFT, since it is the zeroth bit in
> +		 * the error field
> +		 */
> +		if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT)))) {
>  			dev_kfree_skb_any(skb);
>  			continue;
>  		}
>

This change should be made also, separately to i40evf/i40e_txrx.c

