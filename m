From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 4 Jul 2020 12:41:07 -0700
Subject: [Intel-wired-lan] [PATCH] net: fm10k: check size from dma region
In-Reply-To: <CAHE_cOvFC4sjVvVuC-7A8Zqw6=uJP5AAUmZOk5sQ=7bD+ePpgA@mail.gmail.com>
References: <20200703182010.1867-1-bruceshenzk@gmail.com>
 <CAKgT0Uc0sxRmADBozs3BvK2HFsDAcgzwUKWHyu91npQvyFRM1w@mail.gmail.com>
 <CAHE_cOvFC4sjVvVuC-7A8Zqw6=uJP5AAUmZOk5sQ=7bD+ePpgA@mail.gmail.com>
Message-ID: <CAKgT0UdFPjD5YEBjVxkgCc65muNnxq54QPt3iBzm60QY46BCTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Jul 4, 2020 at 9:37 AM Zekun Shen <bruceshenzk@gmail.com> wrote:
>
> On Sat, Jul 04, 2020 at 09:05:48AM -0700, Alexander Duyck wrote:
> > The upper limitation for the size should be 2K or FM10K_RX_BUFSZ, not
> > PAGE_SIZE. Otherwise you are still capable of going out of bounds
> > because the offset is used within the page to push the start of the
> > region up by 2K.
> PAGE_SIZE can drop the warning, as the dma allocated size is PAGE_SIZE.

Yes, but the point I was getting at is that if you are just going to
squelch the warning, but leave the code broken then the warning isn't
of any use and might as well be discarded. Either you limit the value
to 2K which is what the hardware is expected to max out at anyway, or
you just skip the warning and assume hardware will do the right thing.
I'm not even sure this patch is worth the effort if it is just using
some dummy value that is still broken and simply squelches the
warning.

Could you provide more information about how you are encountering the
error? Is this something you are seeing with an actual fm10k device,
or is this something found via code review or static analysis?

> > If this is actually fixing the warning it makes me wonder if the code
> > performing the check is broken itself since we would still be
> > accessing outside of the accessible DMA range.
> The unbounded size is only passed to fm10k_add_rx_frag, which expects
> and checks size to be less than FM10K_RX_HDR_LEN which is 256.
>
> In this way, any boundary between 256 and 4K should work. I could address
> that with a second version.

I was referring to the code in the DMA-API that is generating the
warning being broken, not the code itself. If you can tell me how you
are getting to the warning it would be useful.

Anything over FM10K_RX_BUFSZ will break things. I think that is what
you are missing. The driver splits a single 4K page into 2 pieces and
then gives half off to the stack and uses the other half for the next
receive. If you have a value over 2K you are going to be overwritting
data in another buffer and/or attempting to access memory outside the
DMA region. Both of which would likely cause significant issues and
likely panic the system.
