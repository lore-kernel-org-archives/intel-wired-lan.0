From: Laba, SlawomirX <slawomirx.laba@intel.com>
Date: Wed, 17 Mar 2021 17:27:38 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: fix locking of critical sections
In-Reply-To: <3a4078fe-0be5-745c-91a3-ed83d4dc372f@kpanic.de>
References: <20210316100141.53551-1-sassmann@kpanic.de>
 <20210316101443.56b87cf6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <44b3f5f0-93f8-29e2-ab21-5fd7cc14c755@kpanic.de>
 <20210316132905.5d0f90dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210316150210.00007249@intel.com>
 <3a4078fe-0be5-745c-91a3-ed83d4dc372f@kpanic.de>
Message-ID: <DM6PR11MB3113AB6CE1D93EF28B3A7345876A9@DM6PR11MB3113.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were discussing introducing mutexes in those critical spots for a long time now (in my team).
Stefan, if you find time, you are most welcome to offer your solution with mutexes.

Slawek


-----Original Message-----
From: Stefan Assmann <sassmann@kpanic.de> 
Sent: Wednesday, March 17, 2021 8:50 AM
To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Yang, Lihong <lihong.yang@intel.com>; Laba, SlawomirX <slawomirx.laba@intel.com>; Nunley, Nicholas D <nicholas.d.nunley@intel.com>
Subject: Re: [PATCH] iavf: fix locking of critical sections

On 16.03.21 23:02, Jesse Brandeburg wrote:
> Jakub Kicinski wrote:
>>>> I personally think that the overuse of flags in Intel drivers 
>>>> brings nothing but trouble. At which point does it make sense to 
>>>> just add a lock / semaphore here rather than open code all this 
>>>> with no clear semantics? No code seems to just test the 
>>>> __IAVF_IN_CRITICAL_TASK flag, all the uses look like poor man's 
>>>> locking at a quick grep. What am I missing?
>>>
>>> I agree with you that the locking could be done with other locking 
>>> mechanisms just as good. I didn't invent the current method so I'll 
>>> let Intel comment on that part, but I'd like to point out that what 
>>> I'm making use of is fixing what is currently in the driver.
>>
>> Right, I should have made it clear that I don't blame you for the 
>> current state of things. Would you mind sending a patch on top of 
>> this one to do a conversion to a semaphore?

Sure, I'm happy to help working on the conversion once the current issue is resolved.

>> Intel folks any opinions?
> 
> I know Slawomir has been working closely with Stefan on figuring out 
> the right ways to fix this code.  Hopefully he can speak for himself, 
> but I know he's on Europe time.
> 
> As for conversion to mutexes I'm a big fan, and as long as we don't 
> have too many collisions with the RTNL lock I think it's a reasonable 
> improvement to do, and if Stefan doesn't want to work on it, we can 
> look into whether Slawomir or his team can.

I'd appreciate to be involved.
Thanks!

  Stefan
