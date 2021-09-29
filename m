From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 29 Sep 2021 17:16:28 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 4/5] net/mlx5: Register
 separate reload devlink ops for multiport device
In-Reply-To: <20210929065549.43b13203@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1632916329.git.leonro@nvidia.com>
 <a8bf9a036fe0a590df830a77a31cc81c355f525d.1632916329.git.leonro@nvidia.com>
 <20210929065549.43b13203@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YVR1PKQjsBfvUTPU@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 06:55:49AM -0700, Jakub Kicinski wrote:
> On Wed, 29 Sep 2021 15:00:45 +0300 Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Mulitport slave device doesn't support devlink reload, so instead of
> > complicating initialization flow with devlink_reload_enable() which
> > will be removed in next patch, set specialized devlink ops callbacks
> > for reload operations.
> > 
> > This fixes an error when reload counters exposed (and equal zero) for
> > the mode that is not supported at all.
> > 
> > Fixes: d89ddaae1766 ("net/mlx5: Disable devlink reload for multi port slave device")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > index 47c9f7f5bb79..e85eca6976a9 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > @@ -309,14 +309,17 @@ static struct devlink_ops mlx5_devlink_ops = {
> >  #endif
> >  	.flash_update = mlx5_devlink_flash_update,
> >  	.info_get = mlx5_devlink_info_get,
> > +	.trap_init = mlx5_devlink_trap_init,
> > +	.trap_fini = mlx5_devlink_trap_fini,
> > +	.trap_action_set = mlx5_devlink_trap_action_set,
> > +};
> > +
> > +static struct devlink_ops mlx5_devlink_reload = {
> >  	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
> >  			  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE),
> >  	.reload_limits = BIT(DEVLINK_RELOAD_LIMIT_NO_RESET),
> >  	.reload_down = mlx5_devlink_reload_down,
> >  	.reload_up = mlx5_devlink_reload_up,
> > -	.trap_init = mlx5_devlink_trap_init,
> > -	.trap_fini = mlx5_devlink_trap_fini,
> > -	.trap_action_set = mlx5_devlink_trap_action_set,
> >  };
> >  
> >  void mlx5_devlink_trap_report(struct mlx5_core_dev *dev, int trap_id, struct sk_buff *skb,
> > @@ -791,6 +794,7 @@ static void mlx5_devlink_traps_unregister(struct devlink *devlink)
> >  
> >  int mlx5_devlink_register(struct devlink *devlink)
> >  {
> > +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> >  	int err;
> >  
> >  	err = devlink_params_register(devlink, mlx5_devlink_params,
> > @@ -808,6 +812,9 @@ int mlx5_devlink_register(struct devlink *devlink)
> >  	if (err)
> >  		goto traps_reg_err;
> >  
> > +	if (!mlx5_core_is_mp_slave(dev))
> > +		devlink_set_ops(devlink, &mlx5_devlink_reload);
> 
> Does this work? Where do you make a copy of the ops? ? You can't modify
> the driver-global ops, to state the obvious.

devlink_ops pointer is not constant at this stage, so why can't I copy
reload_* pointers to the "main" devlink ops?

I wanted to avoid to copy all pointers.

Thanks
