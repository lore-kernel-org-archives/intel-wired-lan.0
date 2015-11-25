From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2015 08:24:38 -0800
Subject: [Intel-wired-lan] [RFC PATCH V2 3/3] Ixgbevf: Add migration
	support for ixgbevf driver
In-Reply-To: <5655DB99.3040007@intel.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
 <1448372298-28386-4-git-send-email-tianyu.lan@intel.com>
 <20151124230551-mutt-send-email-mst@redhat.com>
 <56554994.1090305@intel.com>
 <20151125142437-mutt-send-email-mst@redhat.com>
 <5655DB99.3040007@intel.com>
Message-ID: <CAKgT0UdM5NGOARoiCNvh3Hu0xyvfJ-VoRqDu8bg6RyupSCEYHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 25, 2015 at 8:02 AM, Lan, Tianyu <tianyu.lan@intel.com> wrote:
> On 11/25/2015 8:28 PM, Michael S. Tsirkin wrote:
>>
>> Frankly, I don't really see what this short term hack buys us,
>> and if it goes in, we'll have to maintain it forever.
>>
>
> The framework of how to notify VF about migration status won't be
> changed regardless of stopping VF or not before doing migration.
> We hope to reach agreement on this first. Tracking dirty memory still
> need to more discussions and we will continue working on it. Stop VF may
> help to work around the issue and make tracking easier.

The problem is you still have to stop the device at some point for the
same reason why you have to halt the VM.  You seem to think you can
get by without doing that but you can't.  All you do is open the
system up to multiple races if you leave the device running.  The goal
should be to avoid stopping the device until the last possible moment,
however it will still have to be stopped eventually.  It isn't as if
you can migrate memory and leave the device doing DMA and expect to
get a clean state.

I agree with Michael.  The focus needs to be on first addressing dirty
page tracking.  Once you have that you could use a variation on the
bonding solution where you postpone the hot-plug event until near the
end of the migration just before you halt the guest instead of having
to do it before you start the migration.  Then after that we could
look at optimizing things further by introducing a variation that you
could further improve on things by introducing a variation of hot-plug
that would pause the device as I suggested instead of removing it.  At
that point you should be able to have almost all of the key issues
addresses so that you could drop the bond interface entirely.

>> Also, assuming you just want to do ifdown/ifup for some reason, it's
>> easy enough to do using a guest agent, in a completely generic way.
>>
>
> Just ifdown/ifup is not enough for migration. It needs to restore some PCI
> settings before doing ifup on the target machine

That is why I have been suggesting making use of suspend/resume logic
that is already in place for PCI power management.  In the case of a
suspend/resume we already have to deal with the fact that the device
will go through a D0->D3->D0 reset so we have to restore all of the
existing state.  It would take a significant load off of Qemu since
the guest would be restoring its own state instead of making Qemu have
to do all of the device migration work.
