From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 29 Sep 2021 07:39:40 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 0/5] Devlink reload and
 missed notifications fix
In-Reply-To: <YVR0iKIRYDXQbD+o@unreal>
References: <cover.1632916329.git.leonro@nvidia.com>
 <20210929064004.3172946e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YVR0iKIRYDXQbD+o@unreal>
Message-ID: <20210929073940.5d7ed022@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 29 Sep 2021 17:13:28 +0300 Leon Romanovsky wrote:
> On Wed, Sep 29, 2021 at 06:40:04AM -0700, Jakub Kicinski wrote:
> > On Wed, 29 Sep 2021 15:00:41 +0300 Leon Romanovsky wrote:  
> > > This series starts from the fixing the bug introduced by implementing
> > > devlink delayed notifications logic, where I missed some of the
> > > notifications functions.
> > > 
> > > The rest series provides a way to dynamically set devlink ops that is
> > > needed for mlx5 multiport device and starts cleanup by removing
> > > not-needed logic.
> > > 
> > > In the next series, we will delete various publish API, drop general
> > > lock, annotate the code and rework logic around devlink->lock.
> > > 
> > > All this is possible because driver initialization is separated from the
> > > user input now.  
> > 
> > Swapping ops is a nasty hack in my book.
> > 
> > And all that to avoid having two op structures in one driver.
> > Or to avoid having counters which are always 0?  
> 
> We don't need to advertise counters for feature that is not supported.
> In multiport mlx5 devices, the reload functionality is not supported, so
> this change at least make that device to behave like all other netdev
> devices that don't support devlink reload.
> 
> The ops structure is set very early to make sure that internal devlink
> routines will be able access driver back during initialization (btw very
> questionable design choice)

Indeed, is this fixable? Or now that devlink_register() was moved to 
the end of probe netdev can call ops before instance is registered?

> and at that stage the driver doesn't know
> yet which device type it is going to drive.
> 
> So the answer is:
> 1. Can't have two structures.

I still don't understand why. To be clear - swapping full op structures
is probably acceptable if it's a pure upgrade (existing pointers match).
Poking new ops into a structure (in alphabetical order if I understand
your reply to Greg, not destructor-before-contructor) is what I deem
questionable.

> 2. Same behaviour across all netdev devices.

Unclear what this is referring to.
