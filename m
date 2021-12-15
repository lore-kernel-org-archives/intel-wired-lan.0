From: Piotr Raczynski <piotr.raczynski@intel.com>
Date: Wed, 15 Dec 2021 16:47:37 +0100
Subject: [Intel-wired-lan] [PATCH v3 intel-next] ice: add TTY for GNSS
 module for E810T device
In-Reply-To: <bce5f2e32aa835d43c9e2deba39df9342dfbaec7.camel@intel.com>
References: <20211213105234.397045-1-karol.kolacinski@intel.com>
 <bce5f2e32aa835d43c9e2deba39df9342dfbaec7.camel@intel.com>
Message-ID: <20211215154737.GA94623@bpll.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 13, 2021 at 08:14:34PM +0000, Nguyen, Anthony L wrote:
> On Mon, 2021-12-13 at 11:52 +0100, Karol Kolacinski wrote:
> > Add a new ice_gnss.c file for holding the basic GNSS module
> > functions.
> > If the device supports GNSS module, call the new ice_gnss_init and
> > ice_gnss_release functions where appropriate.
> >
> > Implement basic functionality for reading the data from GNSS module
> > using TTY device.
> >
> > Add I2C read AQ command. It is now required for controlling the
> > external
> > physical connectors via external I2C port expander on E810-T
> > adapters.
> >
> > Future changes will introduce write functionality.
> >
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > Signed-off-by: Sudhansu Sekhar Mishra <sudhansu.mishra@intel.com>
> > ---
> > V1 -> V2: Added CONFIG_TTY dependency
> > V2 -> V3: Removed unnecessary & on pf->hw pointer check
> 
> <snip>
> 
> > +       pf = gnss->back;
> > +       if (!pf || !pf->hw || !gnss->tty || !gnss->tty->port) {
> > +               err = -EFAULT;
> > +               goto exit;
> > +       }
> 
> ../drivers/net/ethernet/intel/ice/ice_gnss.c: In function
> ice_gnss_read:
> ../drivers/net/ethernet/intel/ice/ice_gnss.c:30:13: error: wrong type
> argument to unary exclamation mark
>   if (!pf || !pf->hw || !gnss->tty || !gnss->tty->port) {
>              ^
> 
> I believe Piotr's comment meant the &pf->hw check is not needed at all.

Yes, exactly. Sorry if that comment was a little misleading.

Piotr
