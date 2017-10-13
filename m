From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 12 Oct 2017 19:42:33 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v7 4/6] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171013004005.17416-5-vinicius.gomes@intel.com>
References: <20171013004005.17416-1-vinicius.gomes@intel.com>
 <20171013004005.17416-5-vinicius.gomes@intel.com>
Message-ID: <1507862553.31614.53.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-10-12 at 17:40 -0700, Vinicius Costa Gomes wrote:
> This queueing discipline implements the shaper algorithm defined by
> the 802.1Q-2014 Section 8.6.8.2 and detailed in Annex L.
> 
> It's primary usage is to apply some bandwidth reservation to user
> defined traffic classes, which are mapped to different queues via the
> mqprio qdisc.
> 
> Only a simple software implementation is added for now.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> ---

> +/* timediff is in ns, slope is in kbps */
> +static s64 timediff_to_credits(s64 timediff, s32 slope)
> +{
> +	s64 credits = timediff * slope * BYTES_PER_KBIT;
> +
> +	do_div(credits, NSEC_PER_SEC);
> +
> +	return credits;
> +}
> +
> +static s64 delay_from_credits(s64 credits, s32 slope)
> +{
> +	s64 rate = slope * BYTES_PER_KBIT;
> +	s64 delay;
> +
> +	if (unlikely(rate == 0))
> +		return S64_MAX;
> +
> +	delay = -credits * NSEC_PER_SEC;
> +	do_div(delay, rate);
> +
> +	return delay;
> +}
> +
> +static s64 credits_from_len(unsigned int len, s32 slope, s64 port_rate)
> +{
> +	/* As do_div() only works on unsigned quantities, convert
> +	 * slope to a positive number here, and credits to a negative
> +	 * number before returning.
> +	 */
> +	s64 rate = -slope * BYTES_PER_KBIT;
> +	s64 credits;
> +
> +	if (unlikely(port_rate == 0))
> +		return S64_MAX;
> +
> +	credits = len * rate;
> +	do_div(credits, port_rate);
> +
> +	return -credits;
> +}
> +


Your mixing of s64 and u64 is disturbing.

do_div() handles u64, not s64.

div64_s64() might be needed in place of do_div()



