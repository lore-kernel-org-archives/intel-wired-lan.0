From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 8 Mar 2016 11:39:19 -0800
Subject: [Intel-wired-lan] [PATCH 2/5] i40e/i40evf: Add support for bulk
 free in Tx cleanup
In-Reply-To: <20160307173003.5682.90872.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
 <20160307173003.5682.90872.stgit@localhost.localdomain>
Message-ID: <20160308113919.000012c8@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Alex, one comment below.

On Mon, 7 Mar 2016 09:30:03 -0800
Alexander Duyck <aduyck@mirantis.com> wrote:
> @@ -1975,7 +1977,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>  	 * budget and be more aggressive about cleaning up the Tx descriptors.
>  	 */
>  	i40e_for_each_ring(ring, q_vector->tx) {
> -		if (!i40e_clean_tx_irq(ring, vsi->work_limit)) {
> +		if (!i40e_clean_tx_irq(vsi, ring, budget)) {
>  			clean_complete = false;
>  			continue;
>  		}

I'm not sure if this was a search/replace miss or if you intended it,
but I believe that limiting our transmit cleanup work in i40e_napi_poll
to budget is wrong, as transmit cleanup is so cheap compared to rx,
that we typically don't need to limit it to 64 skbs cleaned.  We can't
just have it clean unlimited numbers, so we put in a work limit that is
adjustable via ethtool and defaults to half the ring size.

So this change 
1) breaks the ethtool adjustment of tx work_limit, and
2) significantly decreases the number of transmits we will clean per
poll loop.

