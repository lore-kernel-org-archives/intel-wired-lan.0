From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Wed, 9 Nov 2016 06:41:30 +0000
Subject: [Intel-wired-lan] [PATCH v3] ixgbevf: handle race between close
 and suspend on shutdown
In-Reply-To: <CAKgT0Uc7i=YnVYhzGCwfiwrNzsBvkpVjS7r3Yn_myBtBe08DOg@mail.gmail.com>
References: <20161108201800.10886.90964.stgit@localhost6.localdomain6>
 <CAKgT0Uc7i=YnVYhzGCwfiwrNzsBvkpVjS7r3Yn_myBtBe08DOg@mail.gmail.com>
Message-ID: <87618083B2453E4A8714035B62D6799250709CDF@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
>Sent: Tuesday, November 08, 2016 7:24 PM
>To: Tantilov, Emil S <emil.s.tantilov@intel.com>
>Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
>Subject: Re: [Intel-wired-lan] [PATCH v3] ixgbevf: handle race between
>close and suspend on shutdown
>
>On Tue, Nov 8, 2016 at 12:18 PM, Emil Tantilov
><emil.s.tantilov@intel.com> wrote:
>> When an interface is part of a namespace it is possible that
>> ixgbevf_close() may be called while ixgbevf_suspend() is running
>> which ends up in a double free WARN and/or a BUG in free_msi_irqs()
>>
>> To handle this situation we extend the rtnl_lock() to protect the
>> call to netif_device_detach() and check for !netif_device_present()
>> to avoid entering close while in suspend.
>>
>> Also added rtnl locks to ixgbevf_queue_reset_subtask().
>>
>> -v2 handle the race with netif_device_detach/present() and rtnl
>> locks as suggested by Alex Duyck
>>
>> -v3 add rtnl locks and check in ixgbevf_remove()
>
>I'm not sure where you got the idea that you needed to add the checks
>to ixgbevf_remove, but I'm pretty sure you don't need to.

When injecting PCIe AER error and the device fails to recover we end up 
in a situation where removing the driver (rmmod) will trigger BUG_ON in
free_msi_irqs(), so not exactly a race and the rtnl locks may not be needed,
but we need the check to make sure we don't double free.

If netif_device_present() is not a good check I suppose we can check for __IXGBEVF_DISABLED.

Thanks,
Emil

