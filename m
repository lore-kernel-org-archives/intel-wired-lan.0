From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 23 Nov 2021 15:33:12 -0800
Subject: [Intel-wired-lan] [PATCH net-next 5/6] devlink: Reshuffle
 resource registration logic
In-Reply-To: <YZynSa6s8kBKtSYB@unreal>
References: <cover.1637173517.git.leonro@nvidia.com>
 <6176a137a4ded48501e8a06fda0e305f9cfc787c.1637173517.git.leonro@nvidia.com>
 <20211117204956.6a36963b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YZYFvIK9mkP107tD@unreal>
 <20211118174813.54c3731f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YZfFDSnnjOG+wSyK@unreal>
 <20211119081017.6676843b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YZoHGKqLz6UBk2Sx@unreal>
 <20211122182728.370889f2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YZynSa6s8kBKtSYB@unreal>
Message-ID: <20211123153312.4eecb490@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 23 Nov 2021 10:33:13 +0200 Leon Romanovsky wrote:
> > > You can do it with my approach too. We incremented reference counter
> > > of devlink instance when devlink_nl_cmd_port_split_doit() was called,
> > > and we can safely take devlink->port_list_lock lock before returning
> > > from pre_doit.  
> > 
> > Wait, I thought you'd hold devlink->lock around split/unsplit.  
> 
> I'm holding.
> 
>     519 static int devlink_nl_pre_doit(const struct genl_ops *ops,
>     520                                struct sk_buff *skb, struct genl_info *info)
>     521 {
>     ...
>     529
>     530         mutex_lock(&devlink->lock);

Then I'm confused why you said you need to hold a ref count on devlink.
Is it devlink_unregister() that's not taking devlink->lock?

> > Please look at the port splitting case, mlx5 doesn't implement it
> > but it's an important feature.  
> 
> I'll, but please don't forget that it was RFC, just to present that
> devlink can be changed internally without exposing internals.
> 
> > Either way, IDK how ref count on devlink helps with lifetime of a
> > subobject. You must assume the sub-objects can only be created outside
> > of the time devlink instance is visible or under devlink->lock?  
> 
> The devlink lifetime is:
> stages:        I                   II                   III   
>  devlink_alloc -> devlink_register -> devlink_unregister -> devlink_free.
> 
> All sub-objects should be created between devlink_alloc and devlink_free.
> It will ensure that ->devlink pointer is always valid.
> 
> Stage I:
>  * There is no need to hold any devlink locks or increase reference counter.
>    If driver doesn't do anything crazy during its init, nothing in devlink
>    land will run in parallel. 
> Stage II:
>  * There is a need to hold devlink->lock and/or play with reference counter
>    and/or use fine-grained locks. Users can issue "devlink ..." commands.

So sub-objects can (dis)appear only in I/III or under devlink->lock.
Why did you add the per-sub object list locks, then?
