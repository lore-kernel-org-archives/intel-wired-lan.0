From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Oct 2017 17:46:37 +0200
Subject: [Intel-wired-lan] [PATCH,
	net-next] i40e: avoid 64-bit division where possible
In-Reply-To: <1508253294.2928.2.camel@intel.com>
References: <20171017102351.492492-1-arnd@arndb.de>
 <1508253294.2928.2.camel@intel.com>
Message-ID: <CAK8P3a0qz3or0kcwzzXToQaa42794f4x_Wjcht-BftOypQX8mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 17, 2017 at 5:14 PM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Tue, 2017-10-17 at 12:23 +0200, Arnd Bergmann wrote:
>> The new bandwidth calculation causes a link error on 32-bit
>> architectures, like
>>
>> ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko]
>> undefined!

> Unfortunately your patch does not apply cleanly to my tree.  Arnd,
> could you please rebase your patch based my next-queue tree (dev-queue
> branch)?  I already have several i40e patches queued up and applied to
> that branch.

I see you already applied a fix from Alan Brady on that branch. I think
his version is sufficient to avoid the build problems, but mine is better.
I've rebased my patch now to revert parts of his fix. Please decide for
yourself whether you want to apply it on top, or are happy enough with
the existing version.

       Arnd
