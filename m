From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Tue, 10 Aug 2021 18:08:51 +0530
Subject: [Intel-wired-lan] [PATCH net-next] devlink: Set device as early
 as possible
In-Reply-To: <6859503f7e3e6cd706bf01ef06f1cae8c0b0970b.1628449004.git.leonro@nvidia.com>
References: <6859503f7e3e6cd706bf01ef06f1cae8c0b0970b.1628449004.git.leonro@nvidia.com>
Message-ID: <CAJ2QiJLJk73RDS_XwQ0FY0ODq9qXbmiEZ2Y8Fkz9vVheK4he8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Leon,

On Mon, Aug 9, 2021 at 12:33 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> All kernel devlink implementations call to devlink_alloc() during
> initialization routine for specific device which is used later as
> a parent device for devlink_register().
>
> Such late device assignment causes to the situation which requires us to
> call to device_register() before setting other parameters, but that call
> opens devlink to the world and makes accessible for the netlink users.
>
> Any attempt to move devlink_register() to be the last call generates the
> following error due to access to the devlink->dev pointer.
>
> [    8.758862]  devlink_nl_param_fill+0x2e8/0xe50
> [    8.760305]  devlink_param_notify+0x6d/0x180
> [    8.760435]  __devlink_params_register+0x2f1/0x670
> [    8.760558]  devlink_params_register+0x1e/0x20
>
> The simple change of API to set devlink device in the devlink_alloc()
> instead of devlink_register() fixes all this above and ensures that
> prior to call to devlink_register() everything already set.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  9 ++++---
>  .../net/ethernet/cavium/liquidio/lio_main.c   |  5 ++--
>  .../freescale/dpaa2/dpaa2-eth-devlink.c       |  5 ++--
>  .../hisilicon/hns3/hns3pf/hclge_devlink.c     |  4 +--
>  .../hisilicon/hns3/hns3vf/hclgevf_devlink.c   |  7 ++---
>  .../net/ethernet/huawei/hinic/hinic_devlink.c |  8 +++---
>  .../net/ethernet/huawei/hinic/hinic_devlink.h |  4 +--
>  .../net/ethernet/huawei/hinic/hinic_hw_dev.c  |  2 +-
>  .../net/ethernet/huawei/hinic/hinic_main.c    |  2 +-
>  drivers/net/ethernet/intel/ice/ice_devlink.c  |  4 +--
>  .../marvell/octeontx2/af/rvu_devlink.c        |  5 ++--
>  .../marvell/prestera/prestera_devlink.c       |  7 ++---
>  .../marvell/prestera/prestera_devlink.h       |  2 +-
>  .../ethernet/marvell/prestera/prestera_main.c |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/main.c     |  4 +--
>  .../net/ethernet/mellanox/mlx5/core/devlink.c |  9 ++++---
>  .../net/ethernet/mellanox/mlx5/core/devlink.h |  4 +--
>  .../net/ethernet/mellanox/mlx5/core/main.c    |  4 +--
>  .../mellanox/mlx5/core/sf/dev/driver.c        |  2 +-
>  drivers/net/ethernet/mellanox/mlxsw/core.c    |  5 ++--
>  drivers/net/ethernet/mscc/ocelot_vsc7514.c    |  5 ++--
>  drivers/net/ethernet/netronome/nfp/nfp_main.c |  2 +-
>  .../net/ethernet/netronome/nfp/nfp_net_main.c |  2 +-
>  .../ethernet/pensando/ionic/ionic_devlink.c   |  4 +--
>  drivers/net/ethernet/qlogic/qed/qed_devlink.c |  5 ++--
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  4 +--
>  drivers/net/ethernet/ti/cpsw_new.c            |  4 +--
>  drivers/net/netdevsim/dev.c                   |  4 +--
>  drivers/ptp/ptp_ocp.c                         | 26 +++----------------
>  drivers/staging/qlge/qlge_main.c              |  5 ++--
>  include/net/devlink.h                         | 10 ++++---
>  net/core/devlink.c                            | 15 +++++------
>  net/dsa/dsa2.c                                |  5 ++--
>  33 files changed, 91 insertions(+), 94 deletions(-)
>

<snip>

>
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index ccbfb3a844aa..0236c77f2fd0 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -1544,13 +1544,15 @@ struct net *devlink_net(const struct devlink *devlink);
>   * Drivers that operate on real HW must use devlink_alloc() instead.
>   */
>  struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> -                                size_t priv_size, struct net *net);
> +                                size_t priv_size, struct net *net,
> +                                struct device *dev);
>  static inline struct devlink *devlink_alloc(const struct devlink_ops *ops,
> -                                           size_t priv_size)
> +                                           size_t priv_size,
> +                                           struct device *dev)
>  {
> -       return devlink_alloc_ns(ops, priv_size, &init_net);
> +       return devlink_alloc_ns(ops, priv_size, &init_net, dev);
>  }
> -int devlink_register(struct devlink *devlink, struct device *dev);
> +int devlink_register(struct devlink *devlink);
>  void devlink_unregister(struct devlink *devlink);
>  void devlink_reload_enable(struct devlink *devlink);
>  void devlink_reload_disable(struct devlink *devlink);
> diff --git a/net/core/devlink.c b/net/core/devlink.c
> index ee95eee8d0ed..d3b16dd9f64e 100644
> --- a/net/core/devlink.c
> +++ b/net/core/devlink.c
> @@ -8768,24 +8768,26 @@ static bool devlink_reload_actions_valid(const struct devlink_ops *ops)
>   *     @ops: ops
>   *     @priv_size: size of user private data
>   *     @net: net namespace
> + *     @dev: parent device
>   *
>   *     Allocate new devlink instance resources, including devlink index
>   *     and name.
>   */
>  struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> -                                size_t priv_size, struct net *net)
> +                                size_t priv_size, struct net *net,
> +                                struct device *dev)
>  {
>         struct devlink *devlink;
>
> -       if (WARN_ON(!ops))
> -               return NULL;
> -
> +       WARN_ON(!ops || !dev);
>         if (!devlink_reload_actions_valid(ops))
>                 return NULL;
>
>         devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
>         if (!devlink)
>                 return NULL;
> +
> +       devlink->dev = dev;
>         devlink->ops = ops;
>         xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
>         write_pnet(&devlink->_net, net);
> @@ -8810,12 +8812,9 @@ EXPORT_SYMBOL_GPL(devlink_alloc_ns);
>   *     devlink_register - Register devlink instance
>   *
>   *     @devlink: devlink
> - *     @dev: parent device
>   */

This patch is converting devlink_alloc() to devlink_alloc_register().

There are 2 APIs: devlink_alloc() and devlink_register().
Both APIs can be used in a scenario,
              Where devlink_alloc() can be done by code written around
one struct dev and used by another struct dev.
or
This scenario is not even a valid scenario?

> -int devlink_register(struct devlink *devlink, struct device *dev)
> +int devlink_register(struct devlink *devlink)
>  {
> -       WARN_ON(devlink->dev);
> -       devlink->dev = dev;
>         mutex_lock(&devlink_mutex);
>         list_add_tail(&devlink->list, &devlink_list);
>         devlink_notify(devlink, DEVLINK_CMD_NEW);

Considering device registration has been moved to devlink_alloc().
Can the remaining code of devlink_register() be also moved in devlink_alloc()?

--pk
