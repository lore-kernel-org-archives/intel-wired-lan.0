From: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Date: Sat, 16 Apr 2022 23:43:03 +0200
Subject: [Intel-wired-lan] [PATCH v3] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
In-Reply-To: <1897617.PYKUYFuaPT@leap>
References: <20220416111457.5868-1-eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204161608230.3501@hadrien> <1897617.PYKUYFuaPT@leap>
Message-ID: <4058066.1IzOArtZ34@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On sabato 16 aprile 2022 17:52:20 CEST Fabio M. De Francesco wrote:
> On sabato 16 aprile 2022 16:09:58 CEST Julia Lawall wrote:
> > 
> > If all calls should be changed then you can also say that.
> 
> If all calls should be changed with no regards to the surrounding 
contexts 
> and special situations, we can just make an automated s/kmap()/
> kmap_local_page()/ or something else similar :)

Hi Julia,

Of course I was just kidding when talking of massively automated 
substitutions. They are not feasible and we cannot blindly replace all 
kmap() calls with kmap_local_page().

Although these code changes look good, your objections are appropriate and 
legitimate.

Not all kmap() calls can be changed to kmap_local_page() and, if someone 
wants to make such replacements, they should also "prove" somehow that they 
are doing the right changes in that specific context.

For example, the following is one of those cases where such a replacement 
is not allowed and a different solution has yet to be found:

https://lore.kernel.org/lkml/2a7030f5-d55f-94c7-90ba-5a57235159f6 at amd.com/

Furthermore, if people cannot "prove" that this change is feasible, their  
patches will probably be ignored / rejected just because many maintainers 
still don't know if those changes are correct and safe.

Whoever wants to do these changes should understand the specific context in 
which they are working. 

For example, there have also been cases where alloc_page() + kmap() was 
simply replaced by kmalloc(). Sure!

If you are interested to see how and why, please take a look at the commit 
633b0616cfe0 ("x86/sgx: Remove unnecessary kmap() from 
sgx_ioc_enclave_init()") from Ira Weiny.

Regards,

Fabio

> > 
> > I thought that a previous commit on the outreachy list made some 
> arguments
> > about how the affacted value was just allocated and thus could not yet 
be
> > shared.
> > 
> > julia
> 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220416/daee33e4/attachment-0001.html>
