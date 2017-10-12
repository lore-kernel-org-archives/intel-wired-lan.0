From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 11 Oct 2017 18:32:52 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v6 3/5] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171012005449.26533-4-vinicius.gomes@intel.com>
References: <20171012005449.26533-1-vinicius.gomes@intel.com>
 <20171012005449.26533-4-vinicius.gomes@intel.com>
Message-ID: <1507771972.31614.41.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-10-11 at 17:54 -0700, Vinicius Costa Gomes wrote:
> This queueing discipline implements the shaper algorithm defined by
> the 802.1Q-2014 Section 8.6.8.2 and detailed in Annex L.

...

> +static s64 delay_from_credits(s64 credits, s32 slope)
> +{
> +	s64 rate = slope * BYTES_PER_KBIT;
> +
> +	if (unlikely(rate == 0))
> +		return S64_MAX;
> +
> +	return ((-credits * NSEC_PER_SEC) / rate);
> +}

Have you tried to compile this on 32bit arch ?

make ARCH=i386


