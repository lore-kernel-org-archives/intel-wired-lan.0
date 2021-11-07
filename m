From: Ido Schimmel <idosch@idosch.org>
Date: Sun, 7 Nov 2021 15:44:52 +0200
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/6] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20211105205331.2024623-3-maciej.machnikowski@intel.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-3-maciej.machnikowski@intel.com>
Message-ID: <YYfYVA9j6Dk2rkDD@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Nov 05, 2021 at 09:53:27PM +0100, Maciej Machnikowski wrote:
> +/* SyncE section */
> +
> +enum if_eec_state {
> +	IF_EEC_STATE_INVALID = 0,	/* state is not valid */
> +	IF_EEC_STATE_FREERUN,		/* clock is free-running */
> +	IF_EEC_STATE_LOCKED,		/* clock is locked to the reference,
> +					 * but the holdover memory is not valid
> +					 */
> +	IF_EEC_STATE_LOCKED_HO_ACQ,	/* clock is locked to the reference
> +					 * and holdover memory is valid
> +					 */
> +	IF_EEC_STATE_HOLDOVER,		/* clock is in holdover mode */
> +};
> +
> +#define EEC_SRC_PORT		(1 << 0) /* recovered clock from the port is
> +					  * currently the source for the EEC
> +					  */

Where is this used?

Note that the merge window is open and that net-next is closed:

http://vger.kernel.org/~davem/net-next.html

> +
> +struct if_eec_state_msg {
> +	__u32 ifindex;
> +};
> +
> +enum {
> +	IFLA_EEC_UNSPEC,
> +	IFLA_EEC_STATE,
> +	IFLA_EEC_SRC_IDX,
> +	__IFLA_EEC_MAX,
> +};
> +
> +#define IFLA_EEC_MAX (__IFLA_EEC_MAX - 1)
