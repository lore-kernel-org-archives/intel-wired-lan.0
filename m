From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 29 Sep 2021 13:02:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 21/21] net: dsa: Move
 devlink registration to be last devlink command
In-Reply-To: <66dd7979b44ac307711c382054f428f9287666a8.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
 <66dd7979b44ac307711c382054f428f9287666a8.1632565508.git.leonro@nvidia.com>
Message-ID: <20210929130226.j53fcztm6utpt3tu@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Leon,

On Sat, Sep 25, 2021 at 02:23:01PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> This change prevents from users to access device before devlink
> is fully configured.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  net/dsa/dsa2.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> index a020339e1973..8ca6a1170c9d 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -848,7 +848,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  	dl_priv = devlink_priv(ds->devlink);
>  	dl_priv->ds = ds;
>
> -	devlink_register(ds->devlink);
>  	/* Setup devlink port instances now, so that the switch
>  	 * setup() can register regions etc, against the ports
>  	 */
> @@ -874,8 +873,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  	if (err)
>  		goto teardown;
>
> -	devlink_params_publish(ds->devlink);
> -
>  	if (!ds->slave_mii_bus && ds->ops->phy_read) {
>  		ds->slave_mii_bus = mdiobus_alloc();
>  		if (!ds->slave_mii_bus) {
> @@ -891,7 +888,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  	}
>
>  	ds->setup = true;
> -
> +	devlink_register(ds->devlink);
>  	return 0;
>
>  free_slave_mii_bus:
> @@ -906,7 +903,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>  	list_for_each_entry(dp, &ds->dst->ports, list)
>  		if (dp->ds == ds)
>  			dsa_port_devlink_teardown(dp);
> -	devlink_unregister(ds->devlink);
>  	devlink_free(ds->devlink);
>  	ds->devlink = NULL;
>  	return err;
> @@ -919,6 +915,9 @@ static void dsa_switch_teardown(struct dsa_switch *ds)
>  	if (!ds->setup)
>  		return;
>
> +	if (ds->devlink)
> +		devlink_unregister(ds->devlink);
> +
>  	if (ds->slave_mii_bus && ds->ops->phy_read) {
>  		mdiobus_unregister(ds->slave_mii_bus);
>  		mdiobus_free(ds->slave_mii_bus);
> @@ -934,7 +933,6 @@ static void dsa_switch_teardown(struct dsa_switch *ds)
>  		list_for_each_entry(dp, &ds->dst->ports, list)
>  			if (dp->ds == ds)
>  				dsa_port_devlink_teardown(dp);
> -		devlink_unregister(ds->devlink);
>  		devlink_free(ds->devlink);
>  		ds->devlink = NULL;
>  	}
> --
> 2.31.1
>

Sorry, I did not have time to review/test this change earlier.
I now see this WARN_ON being triggered when I boot a board:

[    6.731180] WARNING: CPU: 1 PID: 79 at net/core/devlink.c:5158 devlink_nl_region_notify+0xa8/0xc0
[    6.740123] Modules linked in:
[    6.743217] CPU: 1 PID: 79 Comm: kworker/u4:2 Tainted: G        W         5.15.0-rc2-07010-ga9b9500ffaac-dirty #876
[    6.759155] Workqueue: events_unbound deferred_probe_work_func
[    6.765048] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.772060] pc : devlink_nl_region_notify+0xa8/0xc0
[    6.776978] lr : devlink_nl_region_notify+0x3c/0xc0
[    6.781893] sp : ffff8000108b38b0
[    6.785235] x29: ffff8000108b38b0 x28: ffff6fce86e53780 x27: ffff6fce86e525c8
[    6.792453] x26: ffff6fce86e69b00 x25: ffff6fce86e57600 x24: 0000000000017528
[    6.799668] x23: 0000000000000001 x22: ffff6fce86e57400 x21: 000000000000002c
[    6.806883] x20: 0000000000000000 x19: ffff6fce86e69b00 x18: 00000000fffffff8
[    6.814098] x17: 000000000000013f x16: 000000000000017f x15: ffffffffffffffff
[    6.821313] x14: ffffff0000000000 x13: ffffffffffffffff x12: 000000000000000b
[    6.828528] x11: ffffc1141c2fce38 x10: 0000000000000005 x9 : 659dd6f91764a956
[    6.835742] x8 : ffff6fce851ce100 x7 : ffffc1141c6bf000 x6 : 000000003020805e
[    6.842956] x5 : 00ffffffffffffff x4 : ffffaebaddb5a000 x3 : 0000000000000000
[    6.850169] x2 : 0000000000000000 x1 : ffff6fce851ce100 x0 : 0000000000000000
[    6.857383] Call trace:
[    6.859854]  devlink_nl_region_notify+0xa8/0xc0
[    6.864422]  devlink_region_create+0x110/0x150
[    6.868902]  dsa_devlink_region_create+0x14/0x20
[    6.873563]  sja1105_devlink_setup+0x54/0xa0
[    6.877871]  sja1105_setup+0x144/0x1390
[    6.881742]  dsa_register_switch+0x978/0x1010
[    6.886139]  sja1105_probe+0x628/0x644
[    6.889920]  spi_probe+0x84/0xe4
[    6.893180]  really_probe.part.0+0x9c/0x31c
[    6.897402]  __driver_probe_device+0x98/0x144
[    6.901797]  driver_probe_device+0xc8/0x160
[    6.906019]  __device_attach_driver+0xb8/0x120
[    6.910501]  bus_for_each_drv+0x78/0xd0
[    6.914373]  __device_attach+0xd8/0x180
[    6.918243]  device_initial_probe+0x14/0x20
[    6.922466]  bus_probe_device+0x9c/0xa4
[    6.926337]  deferred_probe_work_func+0x88/0xc4
[    6.930906]  process_one_work+0x288/0x6f0
[    6.934952]  worker_thread+0x74/0x470
[    6.938646]  kthread+0x160/0x170
[    6.941909]  ret_from_fork+0x10/0x20
[    6.945519] irq event stamp: 64656
