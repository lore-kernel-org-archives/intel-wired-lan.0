From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 29 Mar 2022 10:10:37 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Fix possible overflow
 in LTR decoding
In-Reply-To: <4ab2299e-0460-0366-f1e7-851a3ec94dc7@leemhuis.info>
References: <20220327171407.3657540-1-sasha.neftin@intel.com>
 <4ab2299e-0460-0366-f1e7-851a3ec94dc7@leemhuis.info>
Message-ID: <dc7ebe8c-318e-651b-9b9d-b932336a09f6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/27/2022 20:24, Thorsten Leemhuis wrote:
> On 27.03.22 19:14, Sasha Neftin wrote:
>> When we decode the latency and the max_latency u16 value does not fill
>> the required size and could lead to the wrong LTR representation.
>> Replace the u16 type with the u32 type and allow corrected LTR
>> representation.
>>
>> Fixes: 44a13a5d99c7 ("e1000e: Fix the max snoop/no-snoop latency for 10M")
>> Reported-by: James Hutchinson <jahutchinson99@googlemail.com>
>> Reported-by: Thorsten Leemhuis <regressions@leemhuis.info>
> 
> Please drop me here (I merely forwarded the report) and instead please
> add a 'Link:' tag pointing to the original report for anyone wanting to
> look into the backstory in the future, as explained in
> 'Documentation/process/submitting-patches.rst' and
> 'Documentation/process/5.Posting.rst'? E.g. like this:
> 
> "Link: https://bugzilla.kernel.org/show_bug.cgi?id=215689"
ok. I will drop you in v2.
Some folks complain they have no access to Bugzilla. I will use your 
https://lore.kernel.org/regressions/6801d0ef-9620-0f61-c107-c2c5524952ef at leemhuis.info/
> 
> And if the patch is already good to go: could the maintainer please add
> it when applying the patch?
> 
> In anyone wonders why I care: there are internal and publicly used tools
> and scripts out there that reply on proper "Link" tags. I don't known
> how many, but there is at least one public tool I'm running that cares:
> regzbot, my regression tracking bot, which I use to track Linux kernel
> regressions and generate the regression reports sent to Linus. Proper
> "Link:" tags allow the bot to automatically connect regression reports
> with fixes being posted or applied to resolve the particular regression
> -- which makes regression tracking a whole lot easier and feasible for
> the Linux kernel. That's why it's a great help for me if people set
> proper "Link" tags.
> 
> While at it, let me tell regzbot about this thread:
> #regzbot ^backmonitor:
> https://lore.kernel.org/regressions/6801d0ef-9620-0f61-c107-c2c5524952ef at leemhuis.info/
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
