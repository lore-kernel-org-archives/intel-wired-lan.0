From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 18 Nov 2021 09:50:20 +0200
Subject: [Intel-wired-lan] [PATCH net-next 5/6] devlink: Reshuffle
 resource registration logic
In-Reply-To: <20211117204956.6a36963b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1637173517.git.leonro@nvidia.com>
 <6176a137a4ded48501e8a06fda0e305f9cfc787c.1637173517.git.leonro@nvidia.com>
 <20211117204956.6a36963b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YZYFvIK9mkP107tD@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 17, 2021 at 08:49:56PM -0800, Jakub Kicinski wrote:
> On Wed, 17 Nov 2021 20:26:21 +0200 Leon Romanovsky wrote:
> > -	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
> > -
> > -	mutex_lock(&devlink->lock);
> > -	resource = devlink_resource_find(devlink, NULL, resource_id);
> > -	if (resource) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > +	WARN_ON(devlink_resource_find(devlink, NULL, resource_id));
> 
> This is not atomic with the add now.

And it shouldn't. devlink_resource_find() will return valid resource only
if there driver is completely bogus with races or incorrect allocations of
resource_id.

devlink_*_register(..)
 mutex_lock(&devlink->lock);
 if (devlink_*_find(...)) {
    mutex_unlock(&devlink->lock);
    return ....;
 }
 .....

It is almost always wrong from locking and layering perspective the pattern above,
as it is racy by definition if not protected by top layer.

There are exceptions from the rule above, but devlink is clearly not the
one of such exceptions.

Thanks
