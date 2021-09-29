From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 29 Sep 2021 13:38:23 +0300
Subject: [Intel-wired-lan] [PATCH net-next 3/5] devlink: Allow set
 specific ops callbacks dynamically
In-Reply-To: <4e99e3996118ce0e2da5367b8fc2a427095dfffd.1632909221.git.leonro@nvidia.com>
References: <cover.1632909221.git.leonro@nvidia.com>
 <4e99e3996118ce0e2da5367b8fc2a427095dfffd.1632909221.git.leonro@nvidia.com>
Message-ID: <20210929103823.GK2048@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 01:16:37PM +0300, Leon Romanovsky wrote:
> +void devlink_set_ops(struct devlink *devlink, struct devlink_ops *ops)
> +{
> +	struct devlink_ops *dev_ops = devlink->ops;
> +
> +	WARN_ON(!devlink_reload_actions_valid(ops));
> +
> +#define SET_DEVICE_OP(ptr, name)                                               \
> +	do {                                                                   \
> +		if (ops->name)                                                 \

Could you make "ops" a parameter of the macro instead of hard coding it?

regards,
dan carpenter

> +			if (!((ptr)->name))				       \
> +				(ptr)->name = ops->name;                       \
> +	} while (0)
> +
> +	/* Keep sorted */
> +	SET_DEVICE_OP(dev_ops, reload_actions);
> +	SET_DEVICE_OP(dev_ops, reload_down);
> +	SET_DEVICE_OP(dev_ops, reload_limits);
> +	SET_DEVICE_OP(dev_ops, reload_up);
> +
> +#undef SET_DEVICE_OP
> +}
> +EXPORT_SYMBOL_GPL(devlink_set_ops);

