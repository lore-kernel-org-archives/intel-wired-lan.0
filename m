From: Patil, Kiran <kiran.patil@intel.com>
Date: Tue, 2 Aug 2016 12:16:21 -0700
Subject: [Intel-wired-lan] [PATCH V0] i40e: Program device correctly as
 part of adding flow director entry
In-Reply-To: <57A0E585.7090709@gmail.com>
References: <1469598563-42383-1-git-send-email-kiran.patil@intel.com>
 <1469599316.2851.50.camel@intel.com>
 <9BBC4E0CF881AA4299206E2E1412B62650236576@ORSMSX102.amr.corp.intel.com>
 <57A0E585.7090709@gmail.com>
Message-ID: <57A0F185.1040208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/2/2016 11:25 AM, John Fastabend wrote:
> On 16-07-27 08:52 AM, Wyborny, Carolyn wrote:
>>> -----Original Message-----
>>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>>> Behalf Of Jeff Kirsher
>>> Sent: Tuesday, July 26, 2016 11:02 PM
>>> To: Patil, Kiran <kiran.patil@intel.com>; intel-wired-lan at lists.osuosl.org;
>>> Bowers, AndrewX <andrewx.bowers@intel.com>
>>> Subject: Re: [Intel-wired-lan] [PATCH V0] i40e: Program device correctly as part
>>> of adding flow director entry
>>>
>>> On Tue, 2016-07-26 at 22:49 -0700, Kiran Patil wrote:
>>>> This patch fixes the problem where driver was not programming
>>>> underlying device correctly when user specifies less than full tuple
>>>> set as part of adding flow director entry (for flow-type tcp4/udp4)
>>>> using ethtool.
>>>>
>>>> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
>>>> Change-Id: I90052508f8c172c0da5a4b78b949704b4a59ea78
>>>> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 116
>>>> +++++++++++++++++++++++++
>>>>   1 file changed, 116 insertions(+)
>>>
>>> Andrew, I know your tested-by is already on this, but I also know it was
>>> not tested while in my dev-queue branch of my next-queue tree.  Can you
>>> please verify this patch in my tree?  No need to send another tested-by,
>>> just let me know if your tested-by still stands.
>>
>> Please drop this patch. The i40e team is redesigning this feature
>> with a couple of others and it will be submitted at a future time.
>>
>> Thanks,
>>
>> Carolyn
>> _____________
>
> But wasn't this a bugfix? Shouldn't the bug fix go out now or can I
> expect the redesign shortly. Another thing to consider is a redesign
Redesign will address generic problem, implementation of flow-director 
(w.r.t. mask) whereas this patch is isolated and fixing the bug and it 
will still be required.
	-- Kiran
> may be harder to pull into distributions if you just wanted a simple
> fix like this.
>
> .John
>
>

