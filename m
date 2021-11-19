From: Leon Romanovsky <leon@kernel.org>
Date: Fri, 19 Nov 2021 17:38:53 +0200
Subject: [Intel-wired-lan] [PATCH net-next 5/6] devlink: Reshuffle
 resource registration logic
In-Reply-To: <20211118174813.54c3731f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1637173517.git.leonro@nvidia.com>
 <6176a137a4ded48501e8a06fda0e305f9cfc787c.1637173517.git.leonro@nvidia.com>
 <20211117204956.6a36963b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YZYFvIK9mkP107tD@unreal>
 <20211118174813.54c3731f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YZfFDSnnjOG+wSyK@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 18, 2021 at 05:48:13PM -0800, Jakub Kicinski wrote:
> On Thu, 18 Nov 2021 09:50:20 +0200 Leon Romanovsky wrote:
> > And it shouldn't. devlink_resource_find() will return valid resource only
> > if there driver is completely bogus with races or incorrect allocations of
> > resource_id.
> > 
> > devlink_*_register(..)
> >  mutex_lock(&devlink->lock);
> >  if (devlink_*_find(...)) {
> >     mutex_unlock(&devlink->lock);
> >     return ....;
> >  }
> >  .....
> > 
> > It is almost always wrong from locking and layering perspective the pattern above,
> > as it is racy by definition if not protected by top layer.
> > 
> > There are exceptions from the rule above, but devlink is clearly not the
> > one of such exceptions.
> 
> Just drop the unnecessary "cleanup" patches and limit the amount 
> of driver code we'll have to revert if your approach fails.

My approach works, exactly like it works in other subsystems.
https://lore.kernel.org/netdev/cover.1636390483.git.leonro at nvidia.com/

We are waiting to see your proposal extended to support parallel devlink
execution and to be applied to real drivers.
https://lore.kernel.org/netdev/20211030231254.2477599-1-kuba at kernel.org/

Anyway, you are maintainer, you want half work, you will get half work.

> 
> I spent enough time going back and forth with you.
> 
> Please.

Disagreements are hard for everyone, not only for you.

Thanks
