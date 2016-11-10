From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Thu, 10 Nov 2016 05:48:20 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH] igb: use igb_adapter->io_addr instead
 of e1000_hw->hw_addr
In-Reply-To: <20161110093549.GA24351@calimero.vinschen.de>
References: <1478588780-24480-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161108164214.GF31855@calimero.vinschen.de>
 <alpine.NEB.2.20.17.1611080910530.6177@chris.i8u.org>
 <20161108183739.GA3744@calimero.vinschen.de>
 <CAKgT0UeaoGfOOC1=h4pGk+=FDd5EqvgRGAdk1StLuiW1-M8tVA@mail.gmail.com>
 <20161110093549.GA24351@calimero.vinschen.de>
Message-ID: <alpine.NEB.2.20.17.1611100544220.6177@chris.i8u.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 10 Nov 2016, Corinna Vinschen wrote:

> On Nov  8 11:33, Alexander Duyck wrote:
...
>> The question I would have is what is reading the device when it is in
>> this state.  The watchdog and any other functions that would read the
>> device should be disabled.
>>
>> One possibility could be a race between a call to igb_close and the
>> igb_suspend function.  We have seen some of those pop up recently on
>> ixgbe and it looks like igb has the same bug.  We should probably be
>> using the rtnl_lock to guarantee that netif_device_detach and the call
>> to __igb_close are completed before igb_close could possibly be called
>> by the network stack.
>
> Do you have a pointer to the related ixgbe patch, by any chance?
...
>> The thing is that a suspended device should not be accessed at all.
>> If we are accessing it while it is suspended then that is a bug.  If
>> you could throw a WARN_ON call in igb_rd32 to capture where this is
>> being triggered that might be useful.
>>
>>> - Otherwise assume it's actually a surprise removal.  In theory that
>>>   should somehow trigger a device removal sequence, kind of like
>>>   calling igb_remove, no?
>>
>> Well a read of the MMIO region while suspended is more of a surprise
>> read since there shouldn't be anything going on.  We need to isolate
>> where that read is coming from and fix it.
>
> That would be ideal, but the problem couldn't be reproduced yet apart
> from at a customer's customer site.  It's not clear yet if we can access
> the machine for further testing.

Here's the initial patch for igb I have, but it's on hold awaiting more
changes in ixgbe regarding AER.

-- 
Hisashi T Fujinaka - htodd at twofifty.com
BSEE + BSChem + BAEnglish + MSCS + $2.50 = coffee
-------------- next part --------------
