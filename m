From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 6 Jun 2018 07:23:14 -0700
Subject: [Intel-wired-lan] [net-queue PATCH 0/2] More fixes for ipsec
In-Reply-To: <688b5e38-17b7-ae0c-5045-1bfce8d8d316@tomt.net>
References: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
 <c184d37f-119c-9dc4-5fc8-cbb3b7170703@tomt.net>
 <688b5e38-17b7-ae0c-5045-1bfce8d8d316@tomt.net>
Message-ID: <CAKgT0Uc321r8iuUbpSDBWRg0TQaLK8hi3PF0uy+M7AD3mD7yBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 5, 2018 at 10:52 PM, Andre Tomt <andre@tomt.net> wrote:
> On 05. juni 2018 18:30, Andre Tomt wrote:
>>
>> On 05. juni 2018 17:11, Alexander Duyck wrote:
>>>
>>> This set addresses a few more issues for ipsec.
>>>
>>> 1. We fix the bit definitions for the SECTXSTAT and SECRXSTAT registers.
>>> 2. Use those new definitions to test if fuse or strapping disabled ipsec.
>>> 3. Fix boolean logic testing for if we disabled it correctly in software.
>>> 4. Add additional test to avoid loopback and wait if it isn't needed.
>>
>>
>> Great, I will see if I can get these and the other fix tested on at least
>> this Denverton and two (I think) unaffected Broadwell DE Xeon D 15xx
>> SFP+/10GbaseT variants later this evening.
>>
>> Thanks
>
>
> I've tested a 4.17 kernel with the following patches applied:
>
> ixgbe-use-CONFIG_XFRM_OFFLOAD-instead-of-CONFIG_XFRM.patch
> ixgbe-move-ipsec-init-function-to-before-reset-call.patch
> ixgbe-avoid-loopback-and-fix-boolean-logic-in-ipsec_stop_data.patch
> ixgbe-fix-bit-definitions-and-add-support-for-testing-for-ipsec-support.patch
>
> (I'm too lazy right now to actually match them up with posted subjects)
>
> The Xeon-Ds now also report "esp-hw-offload: off [fixed]". I'm guessing
> these parts, probably beeing similar to the controller in Denvertons, have
> no ipsec offload support and the check do actually work correctly?
>
> 04:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection
> X552 10 GbE SFP+ [8086:15ac]
> 03:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection
> X552/X557-AT 10GBASE-T [8086:15ad]
>
> ipsec support has not been tested, only that they pass normal traffic and
> otherwise behave as expected.
>
> Is there any point in me replying to each on the list with a Tested-By?

You can if you want to. The fact that you replied to this is enough
for me to know it resolves the issue that you saw. Adding a tested by
would likely just get your name added to the patch and eventually the
kernel when they are applied.

Thanks.

- Alex
