From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 17:17:16 +0000
Subject: [Intel-wired-lan] [PATCH S23 01/15] ice: Implement ethtool ops
 for channels
In-Reply-To: <CAP-MU4NnHyFNfV08MpZkO200sYekvrNRhcENh-oB3e7DvKTSrg@mail.gmail.com>
References: <20190627144101.24280-1-anthony.l.nguyen@intel.com>
 <CAP-MU4NnHyFNfV08MpZkO200sYekvrNRhcENh-oB3e7DvKTSrg@mail.gmail.com>
Message-ID: <6f9c96b00f2d3bdfe49deb18492fb2c5478293ed.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-06-28 at 08:38 -0700, Shannon Nelson wrote:
> On Thu, Jun 27, 2019 at 4:08 PM Tony Nguyen <
> anthony.l.nguyen at intel.com> wrote:
> > 
> > +static int ice_set_channels(struct net_device *dev, struct
> > ethtool_channels *ch)
> > +{
> > +       struct ice_netdev_priv *np = netdev_priv(dev);
> > +       struct ice_vsi *vsi = np->vsi;
> > +       struct ice_pf *pf = vsi->back;
> > +       int new_rx = 0, new_tx = 0;
> > +
> > +       /* do not support changing other_count */
> > +       if (ch->other_count)
> > +               return -EINVAL;
> > +
> > +       /* verify request for a valid number of channels */
> > +       if (ch->rx_count > ice_get_max_rxq(pf) ||
> > +           ch->tx_count > ice_get_max_txq(pf))
> > +               return -EINVAL;
> 
> It was recently pointed out to me that these are checked by ethtool
> before calling into here, so this is unnecessary code.
> 

Thanks for the feedback.  I will remove this and submit a v2.

Thanks,
Tony

> sln
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3277 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190628/4bb59f2b/attachment.bin>
