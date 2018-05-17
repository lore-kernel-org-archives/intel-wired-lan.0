From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 17 May 2018 12:13:22 -0700
Subject: [Intel-wired-lan] [next PATCH S92 7/9] i40e: update data
 pointer directly when copying to the buffer
In-Reply-To: <20180517080840.30192-7-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
 <20180517080840.30192-7-alice.michael@intel.com>
Message-ID: <cb24ddfa-9ffd-f027-fe66-a7233638f93f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/17/2018 1:08 AM, Alice Michael wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future patch is going to add a helper function i40e_add_ethtool_stats
> that will help lower the amount of boiler plate code in the
> i40e_get_ethtool_stats function.
> 
> This conversion will take place over many patches, and the helper
> function will work by directly updating a reference to the data pointer.
> 
> Since this would not work combined with the current method of accessing
> data like an array, update all the code that copies stats into the data
> buffer to use direct updates to the pointer instead of array accesses.
> 
> This will prevent incorrect stat updates for patches in between the
> conversion.
> 
> Similarly, when copying strings, we used a separate char *p pointer.
> Instead, use the data pointer directly as it's already a (u8 *) type
> which is the same size.
> 

[...]

>   		/* process Tx ring statistics */
>   		do {
>   			start = u64_stats_fetch_begin_irq(&tx_ring->syncp);
> -			data[i] = tx_ring->stats.packets;
> -			data[i + 1] = tx_ring->stats.bytes;
> +			data[0] = tx_ring->stats.packets;
> +			data[1] = tx_ring->stats.bytes;
>   		} while (u64_stats_fetch_retry_irq(&tx_ring->syncp, start));
> -		i += 2;
> +		data += 2;
>   
>   		/* Rx ring is the 2nd half of the queue pair */
>   		rx_ring = &tx_ring[1];
>   		do {
>   			start = u64_stats_fetch_begin_irq(&rx_ring->syncp);
> -			data[i] = rx_ring->stats.packets;
> -			data[i + 1] = rx_ring->stats.bytes;
> +			data[0] = rx_ring->stats.packets;
> +			data[1] = rx_ring->stats.bytes;
>   		} while (u64_stats_fetch_retry_irq(&rx_ring->syncp, start));
> -		i += 2;
> +		data += 2;
>   	}

These two chunks still using an array reference seem out of place with 
the rest of this patch using pointer references.

sln


