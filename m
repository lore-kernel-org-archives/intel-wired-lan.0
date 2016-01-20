From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 20 Jan 2016 14:44:14 -0800
Subject: [Intel-wired-lan] [next, S23,
	06/13] i40e/i40evf: tunnels can be generic
In-Reply-To: <20160120143950.00002ba0@unknown>
References: <1449705033-4968-7-git-send-email-joshua.a.hay@intel.com>
 <569F04DF.7070102@gmail.com> <20160120143950.00002ba0@unknown>
Message-ID: <CAKgT0Uda_KG-fcodwJ8D+yhN_e737kbJOSKD0A9WzBs+vXrr6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 20, 2016 at 2:39 PM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
> On Tue, 19 Jan 2016 19:54:07 -0800
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> On 12/09/2015 03:50 PM, Hay, Joshua A wrote:
>> > From: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> > -   if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL)) {
>> > +   if ((tx_flags & I40E_TX_FLAGS_TUNNEL)) {
>> >             /* snag network header to get L4 type and address */
>> >             hdr.network = skb_network_header(skb);
>> >
>>
>> So this patch has a major bug right here.  Specifically it is disabling
>> ATR for everything since the logic got flipped an you are checking the
>> outer headers for tunneled frames, and the inner headers for
>> non-tunneled frames.
>
> I've got a patch ready that fixes the "major bug" part, which appears
> to be due to be a combination of several factors leading to this point
> where the code was broken.  Thank you VERY much for catching this.
>
>> There is another bug a bit further down from here where the variable
>> protocol is used which means it is outer header only and as such breaks
>> any cases where you have v4 over v6 or v6 over v4.
>
> Since this issue was not introduced in this patch, I'm going to punt to
> a separate patch to fix the "protocol".
>

That's fine with me.  I actually have a patch already put together to
address the protocol bug.  I just have to finish up sorting out the
ATA issues I am having with the current net-next and once I have that
resolved I will hopefully be able to work on splitting up the patches
a bit more and will submit my v2 either tonight or early tomorrow.

- Alex
