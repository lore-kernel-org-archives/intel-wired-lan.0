From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 29 Sep 2021 17:13:28 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 0/5] Devlink reload and
 missed notifications fix
In-Reply-To: <20210929064004.3172946e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1632916329.git.leonro@nvidia.com>
 <20210929064004.3172946e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YVR0iKIRYDXQbD+o@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 06:40:04AM -0700, Jakub Kicinski wrote:
> On Wed, 29 Sep 2021 15:00:41 +0300 Leon Romanovsky wrote:
> > This series starts from the fixing the bug introduced by implementing
> > devlink delayed notifications logic, where I missed some of the
> > notifications functions.
> > 
> > The rest series provides a way to dynamically set devlink ops that is
> > needed for mlx5 multiport device and starts cleanup by removing
> > not-needed logic.
> > 
> > In the next series, we will delete various publish API, drop general
> > lock, annotate the code and rework logic around devlink->lock.
> > 
> > All this is possible because driver initialization is separated from the
> > user input now.
> 
> Swapping ops is a nasty hack in my book.
> 
> And all that to avoid having two op structures in one driver.
> Or to avoid having counters which are always 0?

We don't need to advertise counters for feature that is not supported.
In multiport mlx5 devices, the reload functionality is not supported, so
this change at least make that device to behave like all other netdev
devices that don't support devlink reload.

The ops structure is set very early to make sure that internal devlink
routines will be able access driver back during initialization (btw very
questionable design choice), and at that stage the driver doesn't know
yet which device type it is going to drive.

So the answer is:
1. Can't have two structures.
2. Same behaviour across all netdev devices.

> 
> Sorry, at the very least you need better explanation for this.

Was it better explained now?
