From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 15 Apr 2016 18:51:59 -0700
Subject: [Intel-wired-lan] [next PATCH S35 11/14] i40e/i40evf: Refactor
 receive routine
In-Reply-To: <20160415171010.00002329@unknown>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460639974-2556-12-git-send-email-harshitha.ramamurthy@intel.com>
 <CAKgT0UfHqgZ=874HiTR6osxFO=y24Z6=a1Q-0E8ab+s9DFsOCw@mail.gmail.com>
 <20160415111913.00007d33@unknown>
 <CAKgT0UdexLp2VeNJYAbNVEai+pEGBf1pak_2kmZD-rHsYreGkQ@mail.gmail.com>
 <20160415171010.00002329@unknown>
Message-ID: <CAKgT0UeSsmhW5b-7VP7to7QEhwFyeKUAjg7_tZsPtHqUc2nUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 15, 2016 at 5:10 PM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
> On Fri, 15 Apr 2016 12:21:24 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> On Fri, Apr 15, 2016 at 11:19 AM, Jesse Brandeburg
>> <jesse.brandeburg@intel.com> wrote:
>> > On Fri, 15 Apr 2016 10:25:37 -0700
>> > Alexander Duyck <alexander.duyck@gmail.com> wrote:
>> >> If due to only the size I really think this should probably be split
>> >> into two patches.  One for the VF and one for the PF.  That way we
>> >> should only be looking at about 1000 lines of change per patch instead
>> >> of 2000 which becomes a bit unwieldy.  If nothing else it makes the
>> >> reviews easier to read as we don't end up with a novel with review
>> >> comments scattered throughout.
>> >
>> > Thanks for all your comments Alex, they're really useful.  I can split
>> > the patches into (at least) two.
>> >
>> > As far as the comments go, most seem to be tweaks/tuning, and unless I
>> > missed it not any bugs yet (but I know the patch was huge)
>> >
>> > So, would it be at all reasonable to proceed with the code basically
>> > unchanged except for splitting it up, if no bugs are noticed during
>> > review?  Then I will follow up with a cleanup series?
>>
>> The only big issue I saw is the RXE bit check being dropped
>> completely.  If you can incorporate that into the cleanup_headers
>> function then I would say the rest is mostly just performance bits
>> that can be cleaned up later.
>>
>> - Alex
>
> Alex,
>
> The patches will be coming from Harshitha, but in the meantime I
> sent them to you after I broke them all apart and added a check for RXE.
>
> I couldn't use cleanup_headers as it doesn't have access to the receive
> descriptor, so rather than adding an argument I just put it inline.
>
> v2:
> split receive refactor patches into pieces that are smaller.
> added check for RXE (receive error) bit being set in the descriptor.
>
> Thanks again!

I looked it over and it generally looks okay but I did find one more
item.  When the data in the first fragment is getting synced for CPU?
From what I can tell it doesn't look like it is.  That may cause
issues on a system that has a more temperamental DMA API.  The fix is
pretty simple it is just a matter of pulling that
dma_sync_single_for_cpu out of the else and place it a few lines down
like what we had for fm10k or igb.

- Alex
