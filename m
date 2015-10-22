From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 22 Oct 2015 10:17:30 -0600
Subject: [Intel-wired-lan] [RFC Patch 00/12] IXGBE: Add live migration
 support for SRIOV NIC
In-Reply-To: <CAJ3xEMhgzfbGf-3Z7GJGxg5VqbWGyKqoTt6c4C54sDNehdXVMg@mail.gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <CAJ3xEMiStMJdGjgO9=MQrhLpBo8ZiTRoOL_P=aC9kyrNi91FSw@mail.gmail.com>
 <1445455227.4059.867.camel@redhat.com>
 <CAJ3xEMhgzfbGf-3Z7GJGxg5VqbWGyKqoTt6c4C54sDNehdXVMg@mail.gmail.com>
Message-ID: <1445530650.5050.19.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-10-22 at 18:58 +0300, Or Gerlitz wrote:
> On Wed, Oct 21, 2015 at 10:20 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> 
> > This is why the typical VF agnostic approach here is to using bonding
> > and fail over to a emulated device during migration, so performance
> > suffers, but downtime is something acceptable.
> 
> bonding in the VM isn't a zero touch solution, right? is it really acceptable?

The bonding solution requires configuring the bond in the guest and
doing the hot unplug/re-plug around migration.  It's zero touch in that
it works on current code with any PF/VF, but it's certainly not zero
configuration in the guest.  Is what acceptable?  The configuration?
The performance?  The downtime?  I don't think we can hope to improve on
the downtime of an emulated device, but obviously the configuration and
performance are not always acceptable or we wouldn't be seeing so many
people working on migration of assigned devices.  Thanks,

Alex

