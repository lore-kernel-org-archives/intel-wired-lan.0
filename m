From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 12 Oct 2020 16:26:16 +0000
Subject: [Intel-wired-lan] [PATCH] net: ethernet: ixgbe: don't propagate
 -ENODEV from ixgbe_mii_bus_init()
In-Reply-To: <20201012081633.7b501cde@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200928071744.18253-1-brgl@bgdev.pl>
 <CAMRc=MexKweGRjF5KNg1saz7NmE+tQq=03oR3wzoMsaTcm+CAA@mail.gmail.com>
 <20201012081633.7b501cde@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <ec4830bd7e15fc867725a867bf088077fdab2c09.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2020-10-12 at 08:16 -0700, Jakub Kicinski wrote:
> On Mon, 12 Oct 2020 14:20:16 +0200 Bartosz Golaszewski wrote:
> > On Mon, Sep 28, 2020 at 9:17 AM Bartosz Golaszewski <brgl@bgdev.pl>
> > wrote:
> > > 
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > 
> > > It's a valid use-case for ixgbe_mii_bus_init() to return -ENODEV
> > > - we
> > > still want to finalize the registration of the ixgbe device.
> > > Check the
> > > error code and don't bail out if err == -ENODEV.
> > > 
> > > This fixes an issue on C3000 family of SoCs where four ixgbe
> > > devices
> > > share a single MDIO bus and ixgbe_mii_bus_init() returns -ENODEV
> > > for
> > > three of them but we still want to register them.
> > > 
> > > Fixes: 09ef193fef7e ("net: ethernet: ixgbe: check the return
> > > value of ixgbe_mii_bus_init()")
> > > Reported-by: Yongxin Liu <yongxin.liu@windriver.com>
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > index 2f8a4cfc5fa1..d1623af30125 100644
> > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > @@ -11032,7 +11032,7 @@ static int ixgbe_probe(struct pci_dev
> > > *pdev, const struct pci_device_id *ent)
> > >                         true);
> > > 
> > >         err = ixgbe_mii_bus_init(hw);
> > > -       if (err)
> > > +       if (err && err != -ENODEV)
> > >                 goto err_netdev;
> > > 
> > >         return 0;
> > 
> > Gentle ping for this patch. Who's picking up networking patches now
> > that David is OoO? Should I Cc someone else?
> 
> Intel went through a maintainer change of its own, and they usually
> pick up their patches and send a PR.
> 
> Tony, do you want me to apply this directly?

Hi Jakub,

I can take it. That way we can get some testing done on it.

Thanks,
Tony
