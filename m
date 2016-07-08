From: Patrick McLean <patrickm@gaikai.com>
Date: Fri, 8 Jul 2016 09:44:49 -0700
Subject: [Intel-wired-lan] [PATCH] (resend) ixgbe: always initialize
	setup_fc
In-Reply-To: <CAD=hENdLDK6Odi=oV2CNsoKR2_z4tM3oSSgtaA0yiyofErwrog@mail.gmail.com>
References: <CAE2NFgXe4uPT1WDVzSq_rr54XA7xDNuedoBgHdtd2_WekNQZ+A@mail.gmail.com>
 <038AE347-E85C-4738-BC91-C8C16AE88620@intel.com>
 <87618083B2453E4A8714035B62D679925066EACF@FMSMSX105.amr.corp.intel.com>
 <CAD=hENdLDK6Odi=oV2CNsoKR2_z4tM3oSSgtaA0yiyofErwrog@mail.gmail.com>
Message-ID: <CAE2NFgVpZoBrNTFV8J3uybuowDj=84nTwgRkta9B0OqGRg-ZDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

How about just initializing it when the rest of the struct is
initialized? This is what is done for every other model.

On Fri, Jul 8, 2016 at 2:47 AM, zhuyj <zyjzyj2000@gmail.com> wrote:
> Sure. setup_fc should not be null. Emil, your patch can fix it well.
>
> On Fri, Jul 8, 2016 at 8:18 AM, Tantilov, Emil S <emil.s.tantilov@intel.com>
> wrote:
>>
>> >-----Original Message-----
>> >From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
>> > On
>> >Behalf Of Rustad, Mark D
>> >Sent: Wednesday, July 06, 2016 4:01 PM
>> >To: Patrick McLean <patrickm@gaikai.com>
>> >Cc: netdev <netdev@vger.kernel.org>; intel-wired-lan <intel-wired-
>> >lan at lists.osuosl.org>
>> >Subject: Re: [Intel-wired-lan] [PATCH] (resend) ixgbe: always initialize
>> >setup_fc
>> >
>> >Patrick McLean <patrickm@gaikai.com> wrote:
>> >
>> >> Gmail mangled my first message, sorry about that. Second attempt.
>> >>
>> >> In ixgbe_init_mac_link_ops_X550em, the code has a special case for
>> >> backplane media type, but does not fall through to the default case,
>> >> so the setup_fc never gets initialized. This causes a panic when it
>> >> later tries to set up the card, and the kernel dereferences the null
>> >> pointer.
>> >>
>> >> This patch lets the the function fall through, which initialized
>> >> setup_fc properly.
>> >
>> >I don't think that this is the right fix. My memory is that fc autoneg is
>>
>> setup_fc() does not configure FC autoneg and it should always be set.
>>
>> I posted an alternative patch that simply sets setup_fc at the beginning
>> of
>> the function. The fall-through in the switch statement is not a good
>> solution
>> because it won't work in case we need to add another case.
>>
>> http://patchwork.ozlabs.org/patch/646228/
>>
>> Thanks,
>> Emil
>>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ixgbe-x550-always-initialize-setup_fc.patch
Type: text/x-patch
Size: 673 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160708/47f39e87/attachment.bin>
