From: Tal Abudi <talabudi@gmail.com>
Date: Fri, 18 Dec 2015 18:31:02 +0200
Subject: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD65AAE803B@ORSMSX114.amr.corp.intel.com>
References: <20151216193058.5383.11943.stgit@localhost.localdomain>
 <9B4A1B1917080E46B64F07F2989DADD65AAE7871@ORSMSX114.amr.corp.intel.com>
 <CAMt9YRrURroSO3TXQ+-y0kvg0k=TvwO-P1VKTD-15U5hJbr_3Q@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD65AAE7897@ORSMSX114.amr.corp.intel.com>
 <CAKSCDrb5WDqRacxm1HuqHQPRzjDAuPm9XbiF=meO9YxyTYv7MA@mail.gmail.com>
 <CAKgT0Ud+X5sZ3XmBhsrvzEQU8NPu1enpWhDy64n=Bi804nR60w@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD65AAE803B@ORSMSX114.amr.corp.intel.com>
Message-ID: <CAKSCDrZe8jOMX34A2gue8P8x3i-qw7Ygq=Mq62OTKRCG4XxCmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> This is most defective a bug, right ?

Todd, Sorry, I meant most definitely a bug.
The condition might imply that this is by-design.

On Fri, Dec 18, 2015 at 5:48 PM, Fujinaka, Todd <todd.fujinaka@intel.com>
wrote:

> Good idea on the renaming Alex. I'll put that on my list.
>
> Todd Fujinaka
> Software Application Engineer
> Networking Division (ND)
> Intel Corporation
> todd.fujinaka at intel.com
> (503) 712-4565
>
> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Friday, December 18, 2015 7:14 AM
> To: Tal Abudi
> Cc: Fujinaka, Todd; Alex Duyck; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] igb: Enable RSS for i211 adapter
>
> On Fri, Dec 18, 2015 at 1:49 AM, Tal Abudi <talabudi@gmail.com> wrote:
> > The I211 supports only 2 queues according to the datasheet.
> > Is there a real difference between E1000_MRQC_ENABLE_RSS_4Q and
> > E1000_MRQC_ENABLE_RSS_8Q ?
>
> I suspect is is just naming.  This should probably be updated to remove
> the _XQ entirely.  On 82575 we only supported 4 queues for RSS, on 82576 it
> was as much as 16 if I recall correctly.  For 82580, i350, and i211 I think
> it is 8, and on i211 it is only 2 but the datasheet calls it out as RSS_4Q
> which I believe refers back to the original
> 82575 documentation.  Since the number varies all over the place we
> probably should go through and rename the define.
>
> > The number of the rss is set inside the adapter and the netdevice's dev.
> > And we can see in igb_init_queue_configuration() that max_rss_queues =
> > IGB_MAX_RX_QUEUES_I211 (2).
>
> Right we only support 2 queues on this hardware, but the datasheet is
> calling out 4Q as that is what it was defined in the first iteration of
> this driver for the 82575 hardware.  We should have probably updated this
> when 82576 was introduced but it looks like the define was never renamed.
>
> > I tested 5.3.2 with this patch on a 2 core system and packets
> > distributed evenly among queues.
>
> Thanks for testing this.  At least we now know that was the issue.
>
> > This is most defective a bug, right ?
>
> This is a bug.  We just need to leave it to the Intel guys to sort out as
> I think there may need to be a rename or move of some of the defines in
> their initialization code.
>
> - Alex
>



-- 
Best regards,
Tal Abudi
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151218/e2bba2f3/attachment.html>
