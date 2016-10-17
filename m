From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 17 Oct 2016 05:21:21 -0700
Subject: [Intel-wired-lan] [PATCH net-next 02/11] net: Introduce new api
 for walking upper and lower devices
In-Reply-To: <1476494931-31813-3-git-send-email-dsa@cumulusnetworks.com>
References: <1476494931-31813-1-git-send-email-dsa@cumulusnetworks.com>
 <1476494931-31813-3-git-send-email-dsa@cumulusnetworks.com>
Message-ID: <20161017052121.2322279d@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 14 Oct 2016 18:28:42 -0700
David Ahern <dsa@cumulusnetworks.com> wrote:

>  
>  /**
> + * netdev_has_upper_dev_all - Check if device is linked to an upper device
> + * @dev: device
> + * @upper_dev: upper device to check
> + *
> + * Find out if a device is linked to specified upper device and return true
> + * in case it is. Note that this checks the entire upper device chain.
> + * The caller must hold rcu lock.
> + */
> +
> +static int __netdev_has_upper_dev(struct net_device *upper_dev, void *data)
> +{
> +	struct net_device *dev = (struct net_device *)data;
> +
> +	if (upper_dev == dev)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +bool netdev_has_upper_dev_all_rcu(struct net_device *dev,
> +				  struct net_device *upper_dev)
> +{
> +	if (netdev_walk_all_upper_dev_rcu(dev, __netdev_has_upper_dev,
> +					  upper_dev))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(netdev_has_upper_dev_all_rcu);

You should write this more succinctly as:

static bool __netdev_has_upper_dev(struct net_device *upper_dev, void *data)
{
	struct net_device *dev = data;

	return upper_dev == dev;
}

bool netdev_has_upper_dev_all_rcu(struct net_device *dev,
				  struct net_device *upper_dev)
{
	return netdev_walk_all_upper_dev_rcu(dev,
			__netdev_has_upper_dev, upper_dev);
}

No if/else needed. No cast of void * ptr need. Use const if possible?
