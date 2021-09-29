From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 29 Sep 2021 07:35:51 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 4/5] net/mlx5: Register
 separate reload devlink ops for multiport device
In-Reply-To: <YVR4qDxiQw95jaWK@unreal>
References: <cover.1632916329.git.leonro@nvidia.com>
 <a8bf9a036fe0a590df830a77a31cc81c355f525d.1632916329.git.leonro@nvidia.com>
 <20210929065549.43b13203@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YVR1PKQjsBfvUTPU@unreal>
 <20210929072631.437ffad9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YVR4qDxiQw95jaWK@unreal>
Message-ID: <20210929073551.16dd2267@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 29 Sep 2021 17:31:04 +0300 Leon Romanovsky wrote:
> On Wed, Sep 29, 2021 at 07:26:31AM -0700, Jakub Kicinski wrote:
> > On Wed, 29 Sep 2021 17:16:28 +0300 Leon Romanovsky wrote:  
> > > devlink_ops pointer is not constant at this stage, so why can't I copy
> > > reload_* pointers to the "main" devlink ops?
> > > 
> > > I wanted to avoid to copy all pointers.  
> > 
> > Hm. I must be missing a key piece here. IIUC you want to have different
> > ops based on some device property. But there is only one
> > 
> > static struct devlink_ops mlx5_devlink_ops;
> > 
> > so how can two devlink instances in the system use that and have
> > different ops without a copy?  
> 
> No, I have two:
> * Base ops - mlx5_devlink_ops
> * Extra reload commands - mlx5_devlink_reload

Still those are global for the driver, no?

What if you have multiple NICs or whatever.
