From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Fri, 28 Jun 2019 08:38:17 -0700
Subject: [Intel-wired-lan] [PATCH S23 01/15] ice: Implement ethtool ops
 for channels
In-Reply-To: <20190627144101.24280-1-anthony.l.nguyen@intel.com>
References: <20190627144101.24280-1-anthony.l.nguyen@intel.com>
Message-ID: <CAP-MU4NnHyFNfV08MpZkO200sYekvrNRhcENh-oB3e7DvKTSrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jun 27, 2019 at 4:08 PM Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>

> +static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
> +{
> +       struct ice_netdev_priv *np = netdev_priv(dev);
> +       struct ice_vsi *vsi = np->vsi;
> +       struct ice_pf *pf = vsi->back;
> +       int new_rx = 0, new_tx = 0;
> +
> +       /* do not support changing other_count */
> +       if (ch->other_count)
> +               return -EINVAL;
> +
> +       /* verify request for a valid number of channels */
> +       if (ch->rx_count > ice_get_max_rxq(pf) ||
> +           ch->tx_count > ice_get_max_txq(pf))
> +               return -EINVAL;

It was recently pointed out to me that these are checked by ethtool
before calling into here, so this is unnecessary code.

sln
