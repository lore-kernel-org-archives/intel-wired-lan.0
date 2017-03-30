From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Thu, 30 Mar 2017 14:45:29 -0700
Subject: [Intel-wired-lan] [next-queue v6 PATCH 7/7] i40e: Add support
 to get switch id and port number for port netdevs
In-Reply-To: <1490833375-2788-8-git-send-email-sridhar.samudrala@intel.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-8-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <20170330144529.0c7ee4c8@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 29 Mar 2017 17:22:55 -0700, Sridhar Samudrala wrote:
> Introduce switchdev_ops to PF and port netdevs to return the switch id via
> SWITCHDEV_ATTR_ID_PORT_PARENT_ID attribute.
> Also, ndo_get_phys_port_name() support is added to port netdevs to return
> the port number.
> 
...
> +static int
> +i40e_port_netdev_get_phys_port_name(struct net_device *dev, char *buf,
> +				    size_t len)
> +{
> +	struct i40e_port_netdev_priv *priv = netdev_priv(dev);
> +	struct i40e_vf *vf;
> +	int ret;
> +
> +	switch (priv->type) {
> +	case I40E_PORT_NETDEV_VF:
> +		vf = (struct i40e_vf *)priv->f;
> +		ret = snprintf(buf, len, "%d", vf->vf_id);
> +		break;
> +	case I40E_PORT_NETDEV_PF:
> +		ret = snprintf(buf, len, "%d", I40E_MAIN_VSI_PORT_ID);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (ret >= len)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}

You are using only an integer here, which forces you to manually name
the netdev in patch 2, and that is what phys_port_name is supposed to
help avoid doing AFAIU.

We have naming rules in Documentation/networking/switchdev.txt for
switch ports suggested as pX for physical ports or pXsY for ports which
are broken out/split.  Could we establish similar suggestion for vf and
pf representors and document it? (note: we may need pf representors for
multi-host devices.)

IMHO naming representors pfr%d or vfr%d would make sense.  This way
actual VF and PF netdevs could be called pf%d and vf%d, and
udev/systemd will give all netdevs nice, meaningful names without any
custom rules.

Sorry for the bike shedding but I was hoping we could save some user
pain by establishing those rules (more or less) upfront.
