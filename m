From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Wed, 30 Jan 2019 10:22:08 -0800
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix potential RX buffer
 starvation for AF_XDP
In-Reply-To: <CAJ+HfNg=vUqUszLX+C6LvYRq8J_X_UiU4x63FCaXWqdRjV5DGA@mail.gmail.com>
References: <1548770630-16189-1-git-send-email-magnus.karlsson@intel.com>
 <20190129111411.3a4c3599@cakuba.hsd1.ca.comcast.net>
 <CAJ8uoz1GJBmC0GFbURvEzY4kDZZ6C7O9+1F+gV0y=GOMGLobUQ@mail.gmail.com>
 <CAJ+HfNg=vUqUszLX+C6LvYRq8J_X_UiU4x63FCaXWqdRjV5DGA@mail.gmail.com>
Message-ID: <20190130102208.63d602d2@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 30 Jan 2019 15:16:15 +0100, Bj?rn T?pel wrote:
> Den ons 30 jan. 2019 kl 10:35 skrev Magnus Karlsson:
> >
> > On Tue, Jan 29, 2019 at 8:15 PM Jakub Kicinski wrote: 
> > >
> > > I may not understand the problem fully, but isn't it kind of normal
> > > that if you create a ring empty you'll never receive packets?  And it
> > > should be reasonably easy to catch while writing an app from scratch
> > > (i.e. it behaves deterministically).  
> >
> > Agree that this should be the normal behavior for a NIC. The question
> > is how to get out of this situation.There are two options: punt this
> > to the application writer or fix this in the driver. I chose to fix
> > the driver since this removes complexity in the application.
> >  
> 
> Magnus' fix addresses a race/timing issue. At zero-copy initialization
> point, if the fill ring was empty, the driver (both i40e and ixgbe)
> would stop retrying to "allocate" zero-copy frames from the fill
> ring. So, frames would never be received, even if the fill ring was
> filled at a later point.
> 
> If the driver runs-dry in terms of Rx buffer if one or more frames has
> been received, the driver will retry polling the fill-ring. However at
> initialization point, if the fill-ring was empty, the driver would
> just give up and never retry.
> 
> As Magnus stated, there is no "notify the kernel that the items has
> appeared in the fill ring" (other than a HW mechanism where the tail
> pointer is a door bell) on the Rx side, so for the Intel drivers it's
> up to the driver to solve this.

Oh, I see, so its a missing piece in an otherwise very fault tolerant
implementation :)  Okay, no objection.

The nfp prototype I did simply fails the program load if there are not
enough buffers to do the initial fill, but that's just a personal
preference.  I tend to return errors in unclear situations more than
most people.
