From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 16 Oct 2020 12:21:26 -0700
Subject: [Intel-wired-lan] ixgbe - only presenting one out of four
 interfaces on 5.9
In-Reply-To: <CAA85sZs9wswn06hd7ien2B_fyqFM9kEWL_-vXQN-sjhqisizaQ@mail.gmail.com>
References: <CAA85sZv=13q8NXbjdf7+R=wu0Q5=Vj9covZ24e9Ew2DCd7S==A@mail.gmail.com>
 <CAA85sZs9wswn06hd7ien2B_fyqFM9kEWL_-vXQN-sjhqisizaQ@mail.gmail.com>
Message-ID: <20201016122122.0a70f5a3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 16 Oct 2020 11:35:15 +0200 Ian Kumlien wrote:
> Adding netdev, someone might have a clue of what to look at...
> 
> On Mon, Oct 12, 2020 at 9:20 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > Hi,
> >
> > I was really surprised when i rebooted my firewall and there was
> > network issues, I was even more surprised when
> > only one of the four ports of my ixbe (x553) nic was available when booted.

Just to be sure you mean that the 3 devices are not present in ip link
show?

> > You can actually see it dmesg... And i tried some basic looking at
> > changes to see if it was obvious.... but..

Showing a full dmesg may be helpful, but looking at what you posted it
seems like the driver gets past the point where netdev gets registered,
so the only thing that could fail after that point AFIACT is
mdiobus_register(). Could be some breakage in MDIO.

Any chance you could fire up perf, bpftrace and install a kretprobe to
see what mdiobus_register() returns? You can rebind the device to the
driver through sysfs.
