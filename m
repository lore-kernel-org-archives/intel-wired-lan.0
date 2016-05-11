From: Mark D Rustad <mrustad@gmail.com>
Date: Tue, 10 May 2016 22:59:47 -0500
Subject: [Intel-wired-lan] [PATCH] e1000e: prevent division by zero if
	TIMINCA is zero
In-Reply-To: <20160510210042.GA19319@redhat.com>
References: <1462563711-30350-1-git-send-email-dvlasenk@redhat.com>
 <5E18E4A4-E10F-46B5-A2F5-FCA10FAA5030@intel.com>
 <20160510210042.GA19319@redhat.com>
Message-ID: <4DFD5422-8197-4699-977E-8DE3624FC198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jarod Wilson <jarod@redhat.com> wrote:

> On Fri, May 06, 2016 at 11:43:17PM +0000, Rustad, Mark D wrote:
>> Denys Vlasenko <dvlasenk@redhat.com> wrote:
>>
>>> Users report that under VMWare, er32(TIMINCA) returns zero.
>>> This causes division by zero at init time as follows:
>>>
>>> ==>            incvalue = er32(TIMINCA) & E1000_TIMINCA_INCVALUE_MASK;
>>>                for (i = 0; i < E1000_MAX_82574_SYSTIM_REREADS; i++) {
>>>                        /* latch SYSTIMH on read of SYSTIML */
>>>                        systim_next = (cycle_t)er32(SYSTIML);
>>>                        systim_next |= (cycle_t)er32(SYSTIMH) << 32;
>>>
>>>                        time_delta = systim_next - systim;
>>>                        temp = time_delta;
>>> ====>                  rem = do_div(temp, incvalue);
>>>
>>> This change makes kernel survive this, and users report that
>>> NIC does work after this change.
>>>
>>> Since on real hardware incvalue is never zero, this should not affect
>>> real hardware use case.
> ...
>> I seem to recall that this was rejected before because it really is  
>> VMWare's
>> bug and, if they fix it, any existing VMs that use this will just work.
>> Changing the driver will only fix it for vms that install a new driver. I
>> don't object to doing it, it just seems like not the most effective  
>> place to
>> address the issue.
>
> You could also have people who never update VMWare, for whom a kernel
> work-around would be better. I think it'd be best to address it both at
> the driver level and the emulated hardware level, to improve things for
> the most possible users. Those who update neither hypervisor or
> kernel/driver, well, they reap what they sow.

That is a sound argument for doing both. I would expect that there are more  
frozen VM images than host environments, but I can certainly imagine that  
some choose to freeze their host. Of course if everything is frozen there  
is no point at all. :-)

I am on an extended vacation, and don't work on e1000e anyway, so I will  
quit my kibitzing here.

--
Mark Rustad, MRustad at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160510/ea7d2a34/attachment.asc>
