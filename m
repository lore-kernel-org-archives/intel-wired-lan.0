From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 2 Aug 2021 19:54:20 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210802164907.GA9832@hoboy.vegasvil.org>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
Message-ID: <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/2/2021 9:49 AM, Richard Cochran wrote:
> On Mon, Aug 02, 2021 at 04:59:33PM +0200, Arnd Bergmann wrote:
> 
>> This is a recurring problem in many drivers, and we have discussed
>> it several times befores, without reaching a consensus. I'm providing
>> a link to the previous email thread for reference, which discusses
>> some related problems, though I can't find what reasons there were
>> against the approach with the extra Kconfig dependency.
> 
> Quoting myself in the thread from 12 Nov 2020:
> 
>    This whole "implies" thing turned out to be a colossal PITA.
> 
>    I regret the fact that it got merged.  It wasn't my idea.
> 
> This whole thing came about because Nicolas Pitre wanted to make PHC
> core support into a module and also to be able to remove dynamic posix
> clock support for tinification.  It has proved to be a never ending
> source of confusion.
> 
> Let's restore the core functionality and remove "implies" for good.
> 
> Thanks,
> Richard
> 

So go back to "select"?

It looks like Arnd proposed in the thread a solution that did a sort of
"please enable this" but still let you disable it.

An alternative (unfortunately per-driver...) solution was to setup the
drivers so that they gracefully fall back to disabling PTP if the PTP
core support is not reachable.. but that obviously requires that drivers
do the right thing, and at least Intel drivers have not tested this
properly.

I'm definitely in favor of removing "implies" entirely. The semantics
are unclear, and the fact that it doesn't handle the case of "i'm
builtin, so my implies can't be modules"...

I don't really like the syntax of the double "depends on A || !A".. I'd
prefer if we had some keyword for this, since it would be more obvious
and not run against the standard logic (A || !A is a tautology!)

Thanks,
Jake

