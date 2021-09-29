From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 29 Sep 2021 22:11:01 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 0/5] Devlink reload and
 missed notifications fix
In-Reply-To: <20210929105537.758d5d85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1632916329.git.leonro@nvidia.com>
 <20210929064004.3172946e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YVR0iKIRYDXQbD+o@unreal>
 <20210929073940.5d7ed022@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YVSG55i75awUpAmn@unreal>
 <20210929105537.758d5d85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YVS6RQfcp2YVxrv3@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 10:55:37AM -0700, Jakub Kicinski wrote:
> On Wed, 29 Sep 2021 18:31:51 +0300 Leon Romanovsky wrote:
> > On Wed, Sep 29, 2021 at 07:39:40AM -0700, Jakub Kicinski wrote:
> > > On Wed, 29 Sep 2021 17:13:28 +0300 Leon Romanovsky wrote:  
> > > > We don't need to advertise counters for feature that is not supported.
> > > > In multiport mlx5 devices, the reload functionality is not supported, so
> > > > this change at least make that device to behave like all other netdev
> > > > devices that don't support devlink reload.
> > > > 
> > > > The ops structure is set very early to make sure that internal devlink
> > > > routines will be able access driver back during initialization (btw very
> > > > questionable design choice)  
> > > 
> > > Indeed, is this fixable? Or now that devlink_register() was moved to 
> > > the end of probe netdev can call ops before instance is registered?
> > >   
> > > > and at that stage the driver doesn't know
> > > > yet which device type it is going to drive.
> > > > 
> > > > So the answer is:
> > > > 1. Can't have two structures.  
> > > 
> > > I still don't understand why. To be clear - swapping full op structures
> > > is probably acceptable if it's a pure upgrade (existing pointers match).
> > > Poking new ops into a structure (in alphabetical order if I understand
> > > your reply to Greg, not destructor-before-contructor) is what I deem
> > > questionable.  
> > 
> > It is sorted simply for readability and not for any other technical
> > reason.
> > 
> > Regarding new ops, this is how we are setting callbacks in RDMA based on
> > actual device support. It works like a charm.
> > 
> > > > 2. Same behaviour across all netdev devices.  
> > > 
> > > Unclear what this is referring to.  
> > 
> > If your device doesn't support devlink reload, it won't print any
> > reload counters at all. It is not the case for the multiport mlx5
> > device. It doesn't support, but still present these counters.
> 
> There's myriad ways you can hide features.
> 
> Swapping ops is heavy handed and prone to data races, I don't like it.

I'm not swapping, but setting only in supported devices.

Anyway, please give me a chance to present improved version of this
mechanism and we will continue from there.

Thanks
