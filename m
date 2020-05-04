From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 4 May 2020 16:20:14 +0200
Subject: [Intel-wired-lan] Does the 'igb` kernel module support setting
 2-Tuple filters (aka `--config-ntuple`) on a i210 NIC?
In-Reply-To: <CAGrNP8=qr3_ZPL7c4oWz0L6hzLSSHjh3iWa52VsUTmJjfUqxdw@mail.gmail.com>
References: <CAGrNP8nfqAZnEoOBsrxrsvszw7T5pdKHG4mt6fVcKB6iigV_BA@mail.gmail.com>
 <87zhaswn5t.fsf@intel.com>
 <CAGrNP8=qr3_ZPL7c4oWz0L6hzLSSHjh3iWa52VsUTmJjfUqxdw@mail.gmail.com>
Message-ID: <92e434ac-6c7d-d51b-20c3-fc0a2bfda21f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Dan,


Please only send plain text messages with no HTML part to mailing lists.


Am 04.05.20 um 15:58 schrieb Dan Williams:

>>> We have a computer logging a high rate of ethernet packets ( 25k
>>>> packets/sec ~70 Mb/sec);   But we're having trouble convincing 
>>>> the hardware to receive all of these packets, at a sustained
>>>> rate -- specifically we're dropping packets while processing
>>>> through the kernel layers. We're currently attempting to
>>>> optimize the network stack,  but we're having trouble setting
>>>> the driver parameters... which is what this message is all
>>>> about.
>> 
>> That's weird. That packet rate is not *that* high, the Linux kernel
>> should be able to handle that fine.
> 
>> Can you give more details of the workload you are running?
> 
> Okay, in more detail: we have two groups of incoming streams:  (for 
> the minimum setup to cause a problem) - 4x Camera Streams  each 
> transmits a 3.2mb image every .1 s, split into jumbo frames (mtu is 
> set to the full 9000) - Constant stream of data from a Lidar at 18k 
> packets / sec.  Each packet is 1206 bytes long. - Both streams 
> continue steady-state, indefinitely (we have verified behavior out
> to 4 hours so far)
> 
> We receive all of these over ethernet, and routed to a single
> network port on a single NIC.   The driver is the 'igb' kernel
> module, as supplied from ubuntu. The OS is Ubuntu 16.04 LTS with a 
> 4.15.0-88-lowlatency kernel.

To debug already fixed problems, please try to reproduce this with
current software, for example Ubuntu 20.04 or a mainline kernel build.

[?]


Kind regards,

Paul


[1]: https://wiki.ubuntu.com/Kernel/MainlineBuilds
