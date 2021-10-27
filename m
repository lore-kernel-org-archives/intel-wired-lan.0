From: Ido Schimmel <idosch@idosch.org>
Date: Wed, 27 Oct 2021 10:10:18 +0300
Subject: [Intel-wired-lan] [RFC v5 net-next 2/5] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20211026173146.1031412-3-maciej.machnikowski@intel.com>
References: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
 <20211026173146.1031412-3-maciej.machnikowski@intel.com>
Message-ID: <YXj7WkEb0PagWfSw@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 26, 2021 at 07:31:43PM +0200, Maciej Machnikowski wrote:
> +/* SyncE section */
> +
> +enum if_eec_state {
> +	IF_EEC_STATE_INVALID = 0,
> +	IF_EEC_STATE_FREERUN,
> +	IF_EEC_STATE_LOCKED,
> +	IF_EEC_STATE_LOCKED_HO_ACQ,

Is this referring to "Locked mode, acquiring holdover: This is a
temporary mode, when coming from free-run, to acquire holdover memory."
?

It seems ice isn't using it, so maybe drop it? Can be added later in
case we have a driver that can report it

There is also "Locked mode, holdover acquired: This is a steady state
mode, entered when holdover memory is acquired." But I assume that's
"IF_EEC_STATE_LOCKED"

> +	IF_EEC_STATE_HOLDOVER,
> +};
