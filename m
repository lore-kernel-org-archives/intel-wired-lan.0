From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 29 Sep 2021 16:07:49 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 21/21] net: dsa: Move
 devlink registration to be last devlink command
In-Reply-To: <20210929130226.j53fcztm6utpt3tu@skbuf>
References: <cover.1632565508.git.leonro@nvidia.com>
 <66dd7979b44ac307711c382054f428f9287666a8.1632565508.git.leonro@nvidia.com>
 <20210929130226.j53fcztm6utpt3tu@skbuf>
Message-ID: <YVRlJagqFInXCgGZ@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 01:02:27PM +0000, Vladimir Oltean wrote:
> Hi Leon,
> 
> On Sat, Sep 25, 2021 at 02:23:01PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > This change prevents from users to access device before devlink
> > is fully configured.
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  net/dsa/dsa2.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> > index a020339e1973..8ca6a1170c9d 100644
> > --- a/net/dsa/dsa2.c
> > +++ b/net/dsa/dsa2.c
> > @@ -848,7 +848,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
> >  	dl_priv = devlink_priv(ds->devlink);
> >  	dl_priv->ds = ds;
> >
> > -	devlink_register(ds->devlink);
> >  	/* Setup devlink port instances now, so that the switch
> >  	 * setup() can register regions etc, against the ports
> >  	 */
> > @@ -874,8 +873,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
> >  	if (err)
> >  		goto teardown;
> >
> > -	devlink_params_publish(ds->devlink);
> > -
> >  	if (!ds->slave_mii_bus && ds->ops->phy_read) {
> >  		ds->slave_mii_bus = mdiobus_alloc();
> >  		if (!ds->slave_mii_bus) {
> > @@ -891,7 +888,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
> >  	}
> >
> >  	ds->setup = true;
> > -
> > +	devlink_register(ds->devlink);
> >  	return 0;
> >
> >  free_slave_mii_bus:
> > @@ -906,7 +903,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
> >  	list_for_each_entry(dp, &ds->dst->ports, list)
> >  		if (dp->ds == ds)
> >  			dsa_port_devlink_teardown(dp);
> > -	devlink_unregister(ds->devlink);
> >  	devlink_free(ds->devlink);
> >  	ds->devlink = NULL;
> >  	return err;
> > @@ -919,6 +915,9 @@ static void dsa_switch_teardown(struct dsa_switch *ds)
> >  	if (!ds->setup)
> >  		return;
> >
> > +	if (ds->devlink)
> > +		devlink_unregister(ds->devlink);
> > +
> >  	if (ds->slave_mii_bus && ds->ops->phy_read) {
> >  		mdiobus_unregister(ds->slave_mii_bus);
> >  		mdiobus_free(ds->slave_mii_bus);
> > @@ -934,7 +933,6 @@ static void dsa_switch_teardown(struct dsa_switch *ds)
> >  		list_for_each_entry(dp, &ds->dst->ports, list)
> >  			if (dp->ds == ds)
> >  				dsa_port_devlink_teardown(dp);
> > -		devlink_unregister(ds->devlink);
> >  		devlink_free(ds->devlink);
> >  		ds->devlink = NULL;
> >  	}
> > --
> > 2.31.1
> >
> 
> Sorry, I did not have time to review/test this change earlier.
> I now see this WARN_ON being triggered when I boot a board:

Sorry about that, it was missed in one of my rebases.
The fix was posted here.
https://lore.kernel.org/all/2ed1159291f2a589b013914f2b60d8172fc525c1.1632916329.git.leonro at nvidia.com

Thanks
