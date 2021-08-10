From: Leon Romanovsky <leon@kernel.org>
Date: Tue, 10 Aug 2021 16:45:20 +0300
Subject: [Intel-wired-lan] [PATCH net-next] devlink: Set device as early
 as possible
In-Reply-To: <CAJ2QiJLJk73RDS_XwQ0FY0ODq9qXbmiEZ2Y8Fkz9vVheK4he8g@mail.gmail.com>
References: <6859503f7e3e6cd706bf01ef06f1cae8c0b0970b.1628449004.git.leonro@nvidia.com>
 <CAJ2QiJLJk73RDS_XwQ0FY0ODq9qXbmiEZ2Y8Fkz9vVheK4he8g@mail.gmail.com>
Message-ID: <YRKC8NKClMyaQOmt@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 10, 2021 at 06:08:51PM +0530, Prabhakar Kushwaha wrote:
> Hi Leon,

<...>

> >  struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> > -                                size_t priv_size, struct net *net)
> > +                                size_t priv_size, struct net *net,
> > +                                struct device *dev)
> >  {
> >         struct devlink *devlink;
> >
> > -       if (WARN_ON(!ops))
> > -               return NULL;
> > -
> > +       WARN_ON(!ops || !dev);
> >         if (!devlink_reload_actions_valid(ops))
> >                 return NULL;
> >
> >         devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
> >         if (!devlink)
> >                 return NULL;
> > +
> > +       devlink->dev = dev;
> >         devlink->ops = ops;
> >         xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
> >         write_pnet(&devlink->_net, net);
> > @@ -8810,12 +8812,9 @@ EXPORT_SYMBOL_GPL(devlink_alloc_ns);
> >   *     devlink_register - Register devlink instance
> >   *
> >   *     @devlink: devlink
> > - *     @dev: parent device
> >   */
> 
> This patch is converting devlink_alloc() to devlink_alloc_register().
> 
> There are 2 APIs: devlink_alloc() and devlink_register().
> Both APIs can be used in a scenario,
>               Where devlink_alloc() can be done by code written around
> one struct dev and used by another struct dev.
> or
> This scenario is not even a valid scenario?

devlink_alloc() is used to allocated netdev structures for newly
initialized device, it is not possible to share same devlink instance
between different devices.

> 
> > -int devlink_register(struct devlink *devlink, struct device *dev)
> > +int devlink_register(struct devlink *devlink)
> >  {
> > -       WARN_ON(devlink->dev);
> > -       devlink->dev = dev;
> >         mutex_lock(&devlink_mutex);
> >         list_add_tail(&devlink->list, &devlink_list);
> >         devlink_notify(devlink, DEVLINK_CMD_NEW);
> 
> Considering device registration has been moved to devlink_alloc().
> Can the remaining code of devlink_register() be also moved in devlink_alloc()?

The line "list_add_tail(&devlink->list, &devlink_list);" makes the
devlink instance visible to the devlink netlink users. We need to be
sure that it is happening when the device is already initialized, while
devlink_alloc() is performed usually as first line in .probe() routine.

This means that we can't combine alloc an register and
devlink_alloc_register() can't be valid scenario.

Thanks

> 
> --pk
