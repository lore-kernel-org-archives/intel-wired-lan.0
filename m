From: Leon Romanovsky <leon@kernel.org>
Date: Tue, 28 Sep 2021 10:34:33 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 01/21] devlink: Notify
 users when objects are accessible
In-Reply-To: <97c1ba9d-52b9-5689-19ab-ad4a82e55ae2@gmail.com>
References: <cover.1632565508.git.leonro@nvidia.com>
 <0f7f201a059b24c96eac837e1f424e2483254e1c.1632565508.git.leonro@nvidia.com>
 <97c1ba9d-52b9-5689-19ab-ad4a82e55ae2@gmail.com>
Message-ID: <YVLFiUQp03qzBMO5@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 27, 2021 at 07:49:18PM -0700, Eric Dumazet wrote:
> 
> 
> On 9/25/21 4:22 AM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The devlink core code notified users about add/remove objects without
> > relation if this object can be accessible or not. In this patch we unify
> > such user visible notifications in one place.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  net/core/devlink.c | 107 +++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 93 insertions(+), 14 deletions(-)

<...>

> >  static void devlink_rate_notify(struct devlink_rate *devlink_rate,
> >  				enum devlink_command cmd)
> >  {
> > +	struct devlink *devlink = devlink_rate->devlink;
> >  	struct sk_buff *msg;
> >  	int err;
> >  
> >  	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
> > +	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
> 
> 
> FYI, this new warning was triggered by syzbot :

Thanks for the report, it is combination of my rebase error and missing
loop of devlink_rate_notify in the devlink_notify_register() function.

I'll fix and resubmit.

Thanks
