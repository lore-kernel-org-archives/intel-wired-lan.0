From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 3 Nov 2020 08:35:09 +0100
Subject: [Intel-wired-lan] [PATCH 2/2] ethernet: igb: e1000_phy: Check
 for ops.force_speed_duplex existence
In-Reply-To: <20201102161943.343586b1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
References: <20201102231307.13021-1-pmenzel@molgen.mpg.de>
 <20201102231307.13021-3-pmenzel@molgen.mpg.de>
 <20201102161943.343586b1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Message-ID: <36ce1f2e-843c-4995-8bb2-2c2676f01b9d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jakub,


Am 03.11.20 um 01:19 schrieb Jakub Kicinski:
> On Tue,  3 Nov 2020 00:13:07 +0100 Paul Menzel wrote:
>> From: Jeffrey Townsend <jeffrey.townsend@bigswitch.com>
>>
>> The ops field might no be defined, so add a check.
> 
> This change should be first, otherwise AFAIU if someone builds the
> kernel in between the commits (e.g. for bisection) it will crash.

Patch `[PATCH 1/2] ethernet: igb: Support PHY BCM5461S` has

     phy->ops.force_speed_duplex = igb_phy_force_speed_duplex_82580;

so the ordering does not matter. I do not know, if Jeffrey can comment, 
but probably the check was just adding during development. Maybe an 
assert should be added instead?

>> The patch is taken from Open Network Linux (ONL), and it was added there
>> as part of the patch
>>
>>      packages/base/any/kernels/3.16+deb8/patches/driver-support-intel-igb-bcm5461X-phy.patch
>>
>> in ONL commit f32316c63c (Support the BCM54616 and BCM5461S.) [1]. Part
>> of this commit was already upstreamed in Linux commit eeb0149660 (igb:
>> support BCM54616 PHY) in 2017.
>>
>> I applied the forward-ported
>>
>>      packages/base/any/kernels/5.4-lts/patches/0002-driver-support-intel-igb-bcm5461S-phy.patch
>>
>> added in ONL commit 5ace6bcdb3 (Add 5.4 LTS kernel build.) [2].
>>
>> [1]: https://github.com/opencomputeproject/OpenNetworkLinux/commit/f32316c63ce3a64de125b7429115c6d45e942bd1
>> [2]: https://github.com/opencomputeproject/OpenNetworkLinux/commit/5ace6bcdb37cb8065dcd1d4404b3dcb6424f6331
> 
> No need to put this in every commit message.
> 
> We preserve the cover letter in tree as a merge commit message, so
> explaining things once in the cover letter is sufficient.

I remember, but still find it confusing. If I look at a commit with `git 
show ?`, I normally do not think of also looking at a possible cover 
letter as not many subsystems/projects do it, and I assume a commit is 
self-contained.

Could you share your development process

>> Cc: Jeffrey Townsend <jeffrey.townsend@bigswitch.com>
> 
> Jefferey will need to provide a sign-off as the author.

According to *Developer's Certificate of Origin 1.1* [3], it?s my 
understanding, that it is *not* required. The items (a), (b), and (c) 
are connected by an *or*.

>         (b) The contribution is based upon previous work that, to the best
>             of my knowledge, is covered under an appropriate open source
>             license and I have the right under that license to submit that
>             work with modifications, whether created in whole or in part 
>             by me, under the same open source license (unless I am
>             permitted to submit under a different license), as indicated
>             in the file; or

>> Cc: John W Linville <linville@tuxdriver.com>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


[3]: 
https://www.kernel.org/doc/html/v5.9/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
