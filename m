From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 May 2018 13:30:30 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: release lock for the
 duration of ixgbe_suspend_close()
In-Reply-To: <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com>
 <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
Message-ID: <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alex,

> I'm not a fan of dropping the mutex while we go through
> ixgbe_close_suspend. I'm concerned it will result in us having a
> number of races on shutdown.

I would agree, but ixgbe_close_suspend() is already called without this
mutex from ixgbe_close(). This path is executed also during machine
shutdown but when kexec'ed. So, it is either an existing bug or there are
no races. But, because ixgbe_close() is called from the userland, and a
little earlier than ixgbe_shutdown() I think this means there are no races.


> If anything, I think we would need to find a replacement for the mutex
> that can operate at the per-netdev level if you are wanting to
> parallelize this.

Yes, if lock is necessary, it can be replaced in this place (and added to
ixgbe_close())  with something scalable.

Thank you,
Pavel
