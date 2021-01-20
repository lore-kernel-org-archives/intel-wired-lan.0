From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Jan 2021 18:17:12 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 1/8] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <20210119004028.2809425-2-vinicius.gomes@intel.com>
References: <20210119004028.2809425-1-vinicius.gomes@intel.com>
 <20210119004028.2809425-2-vinicius.gomes@intel.com>
Message-ID: <20210119181712.18f0ee24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 Jan 2021 16:40:21 -0800 Vinicius Costa Gomes wrote:
> +  ====================================  ======  ==========================
> +  ``ETHTOOL_A_CHANNELS_HEADER``         nested  request header

ETHTOOL_A_PREEMPT_HEADER

> +  ====================================  ======  ==========================
> +
> +Kernel response contents:
> +
> +  =====================================  ======  ==========================
> +  ``ETHTOOL_A_CHANNELS_HEADER``          nested  reply header

here as well

> +  ``ETHTOOL_A_PREEMPT_ENABLED``          u8      frame preemption enabled
> +  ``ETHTOOL_A_PREEMPT_ADD_FRAG_SIZE``    u32     Min additional frag size
> +  =====================================  ======  ==========================
> +
> +``ETHTOOL_A_PREEMPT_ADD_FRAG_SIZE`` configures the minimum non-final
> +fragment size that the receiver device supports.
> +
> +PREEMPT_SET
> +============
> +
> +Sets frame preemption parameters.
> +
> +Request contents:
> +
> +  =====================================  ======  ==========================
> +  ``ETHTOOL_A_CHANNELS_HEADER``          nested  reply header

and here

> +  ``ETHTOOL_A_PREEMPT_ENABLED``          u8      frame preemption enabled
> +  ``ETHTOOL_A_PREEMPT_ADD_FRAG_SIZE``    u32     Min additional frag size
> +  =====================================  ======  ==========================

> +struct netlink_ext_ack;

Let's move it all the way to the top, right after header includes, so
we don't have to move it again.

> +/**
> + * Convert from a Frame Preemption Additional Fragment size in bytes
> + * to a multiplier. The multiplier is defined as:
> + *	"A 2-bit integer value used to indicate the minimum size of
> + *	non-final fragments supported by the receiver on the given port
> + *	associated with the local System. This value is expressed in units
> + *	of 64 octets of additional fragment length."
> + *	Equivalent to `30.14.1.7 aMACMergeAddFragSize` from the IEEE 802.3-2018
> + *	standard.

Please double check the correct format for kdoc:

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

This comment should also be next to the definition of the function, 
not in the header.

> + * @frag_size: minimum non-final fragment size in bytes
> + *
> + * Returns the multiplier.
> + */
> +u8 ethtool_frag_size_to_mult(u32 frag_size);
