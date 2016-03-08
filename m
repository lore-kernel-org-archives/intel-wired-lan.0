From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 8 Mar 2016 11:47:17 -0800
Subject: [Intel-wired-lan] [next PATCH v2] i40e/i40evf: Allow up to 12K
 bytes of data per Tx descriptor instead of 8K
In-Reply-To: <20160219201130.16927.24329.stgit@localhost.localdomain>
References: <20160219201130.16927.24329.stgit@localhost.localdomain>
Message-ID: <20160308114717.000053d3@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Alex, a couple minor comments.

As an aside, it would be interesting to know if there is a way to get
25us tx-ITR single stream performance while not using so much CPU when
multiple threads get involved.

On Fri, 19 Feb 2016 12:17:08 -0800
Alexander Duyck <aduyck@mirantis.com> wrote:

> >From what I can tell the practical limitation on the size of the Tx data
extra >

> buffer is the fact that the Tx descriptor is limited to 14 bits.  As such
> we cannot use 16K as is typically used on the other Intel drivers.  However
> artificially limiting ourselves to 8K can be expensive as this means that
> we will consume up to 10 descriptors (1 context, 1 for header, and 9 for
> payload, non-8K aligned) in a single send.

...


> +static inline unsigned int i40e_txd_use_count(unsigned int size)
> +{
> +	const unsigned int max = I40E_MAX_DATA_PER_TXD_ALIGNED;
> +	const unsigned int reciprocal = ((1ull << 32) - 1 + (max / 2)) / max;
> +	unsigned int adjust = ~(u32)0;
> +
> +	/* if we rounded up on the reciprprocal pull down the adjustment */

spelling of reciprocal...

> +	if ((max * reciprocal) > adjust)
> +		adjust = ~(u32)(reciprocal - 1);
> +
> +	return (u32)((((u64)size * reciprocal) + adjust) >> 32);
> +}

...

> +static inline unsigned int i40e_txd_use_count(unsigned int size)
> +{
> +	const unsigned int max = I40E_MAX_DATA_PER_TXD_ALIGNED;
> +	const unsigned int reciprocal = ((1ull << 32) - 1 + (max / 2)) / max;
> +	unsigned int adjust = ~(u32)0;
> +
> +	/* if we rounded up on the reciprprocal pull down the adjustment */

Spelling of reciprocal

> +	if ((max * reciprocal) > adjust)
> +		adjust = ~(u32)(reciprocal - 1);
> +
> +	return (u32)((((u64)size * reciprocal) + adjust) >> 32);
> +}
