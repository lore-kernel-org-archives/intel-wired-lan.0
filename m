From: Ido Schimmel <idosch@idosch.org>
Date: Tue, 21 Sep 2021 16:15:55 +0300
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210903151436.529478-2-maciej.machnikowski@intel.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-2-maciej.machnikowski@intel.com>
Message-ID: <YUnbCzBOPP9hWQ5c@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 03, 2021 at 05:14:35PM +0200, Maciej Machnikowski wrote:
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index eebd3894fe89..78a8a5af8cd8 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1273,4 +1273,35 @@ enum {
>  
>  #define IFLA_MCTP_MAX (__IFLA_MCTP_MAX - 1)
>  
> +/* SyncE section */
> +
> +enum if_eec_state {
> +	IF_EEC_STATE_INVALID = 0,
> +	IF_EEC_STATE_FREERUN,
> +	IF_EEC_STATE_LOCKACQ,
> +	IF_EEC_STATE_LOCKREC,
> +	IF_EEC_STATE_LOCKED,
> +	IF_EEC_STATE_HOLDOVER,
> +	IF_EEC_STATE_OPEN_LOOP,
> +	__IF_EEC_STATE_MAX,

Can you document these states? I'm not clear on what LOCKACQ, LOCKREC
and OPEN_LOOP mean. I also don't see ice using them and it's not really
a good practice to add new uAPI without any current users.

From v1 I understand that these states were copied from commit
797d3186544f ("ptp: ptp_clockmatrix: Add wait_for_sys_apll_dpll_lock.")
from Renesas.

Figure 11 in the following PDF describes the states, but it seems
specific to the particular device and probably shouldn't be exposed to
user space as-is:
https://www.renesas.com/us/en/document/dst/8a34041-datasheet

I have a few questions about this being a per-netdev attribute:

1. My understanding is that in the multi-port adapter you are working
with you have a single EEC that is used to set the Tx frequency of all
the ports. Is that correct?

2. Assuming the above is correct, is it possible that one port is in
LOCKED state and another (for some reason) is in HOLDOVER state? If yes,
then I agree about this being a per-netdev attribute. The interface can
also be extended with another attribute specifying the HOLDOVER reason.
For example, netdev being down.

Regardless, I agree with previous comments made about this belonging in
ethtool rather than rtnetlink.

> +};
> +
> +#define IF_EEC_STATE_MAX	(__IF_EEC_STATE_MAX - 1)
> +#define EEC_SRC_PORT		(1 << 0) /* recovered clock from the port is
> +					  * currently the source for the EEC
> +					  */

I'm not sure about this one. If we are going to expose this as a
per-netdev attribute (see more below), any reason it can't be added as
another state (e.g., IF_EEC_STATE_LOCKED_SRC)?

IIUC, in the common case of a simple NE the source of the EEC is always
one of the ports, but in the case of a PRC the source is most likely
external (e.g., GPS).

If so, I think we need a way to represent the EEC as a separate object
with the ability to set its source and report it via the same interface.
I'm unclear on how exactly an external source looks like, but for the
netdev case maybe something like this:

devlink clock show [ dev clock CLOCK ]
devlink clock set DEV clock CLOCK [ { src_type SRC_TYPE } ]
SRC_TYPE : = { port DEV/PORT_INDEX }

The only source type above is 'port' with the ability to set the
relevant port, but more can be added. Obviously, 'devlink clock show'
will give you the current source in addition to other information such
as frequency difference with respect to the input frequency.

Finally, can you share more info about the relation to the PHC? My
understanding is that one of the primary use cases for SyncE is to drive
all the PHCs in the network using the same frequency. How do you imagine
this configuration is going to look like? Can the above interface be
extended for that?

All of the above might be complete nonsense as I'm still trying to wrap
my head around the subject.

Thanks for working on this
