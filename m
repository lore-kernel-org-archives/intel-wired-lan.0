From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 29 Sep 2021 14:25:00 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1 3/5] devlink: Allow set
 specific ops callbacks dynamically
In-Reply-To: <aac64d4861d6207a90a6d45245ee5ed59114659a.1632916329.git.leonro@nvidia.com>
References: <cover.1632916329.git.leonro@nvidia.com>
 <aac64d4861d6207a90a6d45245ee5ed59114659a.1632916329.git.leonro@nvidia.com>
Message-ID: <YVRbHMODzcciHa2p@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 03:00:44PM +0300, Leon Romanovsky wrote:
> +void devlink_set_ops(struct devlink *devlink, struct devlink_ops *ops)
> +{
> +	struct devlink_ops *dev_ops = devlink->ops;
> +
> +	WARN_ON(!devlink_reload_actions_valid(ops));
> +
> +#define SET_DEVICE_OP(ptr, op, name)                                           \
> +	do {                                                                   \
> +		if ((op)->name)                                                \
> +			if (!((ptr)->name))                                    \
> +				(ptr)->name = (op)->name;                      \
> +	} while (0)
> +
> +	/* Keep sorted */
> +	SET_DEVICE_OP(dev_ops, ops, reload_actions);
> +	SET_DEVICE_OP(dev_ops, ops, reload_down);
> +	SET_DEVICE_OP(dev_ops, ops, reload_limits);
> +	SET_DEVICE_OP(dev_ops, ops, reload_up);

Keep sorted in what order?  And why?

thanks,

greg k-h
