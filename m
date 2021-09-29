From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 29 Sep 2021 07:26:31 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 4/5] net/mlx5: Register
 separate reload devlink ops for multiport device
In-Reply-To: <YVR1PKQjsBfvUTPU@unreal>
References: <cover.1632916329.git.leonro@nvidia.com>
 <a8bf9a036fe0a590df830a77a31cc81c355f525d.1632916329.git.leonro@nvidia.com>
 <20210929065549.43b13203@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YVR1PKQjsBfvUTPU@unreal>
Message-ID: <20210929072631.437ffad9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 29 Sep 2021 17:16:28 +0300 Leon Romanovsky wrote:
> > > @@ -808,6 +812,9 @@ int mlx5_devlink_register(struct devlink *devlink)
> > >  	if (err)
> > >  		goto traps_reg_err;
> > >  
> > > +	if (!mlx5_core_is_mp_slave(dev))
> > > +		devlink_set_ops(devlink, &mlx5_devlink_reload);  
> > 
> > Does this work? Where do you make a copy of the ops? ? You can't modify
> > the driver-global ops, to state the obvious.  
> 
> devlink_ops pointer is not constant at this stage, so why can't I copy
> reload_* pointers to the "main" devlink ops?
> 
> I wanted to avoid to copy all pointers.

Hm. I must be missing a key piece here. IIUC you want to have different
ops based on some device property. But there is only one

static struct devlink_ops mlx5_devlink_ops;

so how can two devlink instances in the system use that and have
different ops without a copy?
