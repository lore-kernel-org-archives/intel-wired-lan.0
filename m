From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 May 2018 06:46:05 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: release lock for the
 duration of ixgbe_suspend_close()
In-Reply-To: <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com>
 <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
 <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
Message-ID: <CAKgT0UfNBugQywBZuepUJ6deEYsSWmTw3b6VbQBJLn-kKXe7ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 3, 2018 at 6:30 AM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Hi Alex,

Hi Pavel,

>> I'm not a fan of dropping the mutex while we go through
>> ixgbe_close_suspend. I'm concerned it will result in us having a
>> number of races on shutdown.
>
> I would agree, but ixgbe_close_suspend() is already called without this
> mutex from ixgbe_close(). This path is executed also during machine
> shutdown but when kexec'ed. So, it is either an existing bug or there are
> no races. But, because ixgbe_close() is called from the userland, and a
> little earlier than ixgbe_shutdown() I think this means there are no races.

All callers of ixgbe_close are supposed to already be holding the RTNL
mutex. That is the whole reason why we need to hold it here as the
shutdown path doesn't have the mutex held otherwise. The mutex was
added here because shutdown was racing with the open/close calls.

>
>> If anything, I think we would need to find a replacement for the mutex
>> that can operate at the per-netdev level if you are wanting to
>> parallelize this.
>
> Yes, if lock is necessary, it can be replaced in this place (and added to
> ixgbe_close())  with something scalable.

I wouldn't suggest adding yet another lock for all this. Instead it
might make more sense for us to start looking at breaking up the
locking since most of the networking subsystem uses the rtnl_lock call
it might be time to start looking at doing something like cutting back
on the use of this in cases where all the resources needed are
specific to one device and instead have a per device lock that could
address those kind of cases.

- Alex
