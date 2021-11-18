From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 18 Nov 2021 09:32:20 +0200
Subject: [Intel-wired-lan] [PATCH net-next 4/6] devlink: Clean
 registration of devlink port
In-Reply-To: <20211117204929.4bd24597@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1637173517.git.leonro@nvidia.com>
 <9c3eb77a90a2be10d5c637981a8047160845f60f.1637173517.git.leonro@nvidia.com>
 <20211117204929.4bd24597@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YZYBhArHOAbLfOUb@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 17, 2021 at 08:49:29PM -0800, Jakub Kicinski wrote:
> On Wed, 17 Nov 2021 20:26:20 +0200 Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > devlink_port_register() is in-kernel API and as such can't really fail
> > as long as driver author didn't make a mistake by providing already existing
> > port index. Instead of relying on various error prints from the driver,
> > convert the existence check to be WARN_ON(), so such a mistake will be
> > caught easier.
> > 
> > As an outcome of this conversion, it was made clear that this function
> > should be void and devlink->lock was intended to protect addition to
> > port_list.
> 
> Leave this error checking in please.

Are you referring to error checks in the drivers or the below section
from devlink_port_register()?

       mutex_lock(&devlink->lock);
       if (devlink_port_index_exists(devlink, port_index)) {
               mutex_unlock(&devlink->lock);
               return -EEXIST;
       }

Because if it is latter, any driver (I didn't find any) that will rely
on this -EEXIST field should have some sort of locking in top level.
Otherwise nothing will prevent from doing port unregister right
before "return --EXEEXIST".

So change to WARN_ON() will be much more effective in finding wrong
drivers, because they manage port_index and not devlink.

And because this function can't fail, the drivers have a plenty of dead
code.

Thanks
