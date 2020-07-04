From: Zekun Shen <bruceshenzk@gmail.com>
Date: Sat, 4 Jul 2020 12:37:04 -0400
Subject: [Intel-wired-lan] [PATCH] net: fm10k: check size from dma region
In-Reply-To: <CAKgT0Uc0sxRmADBozs3BvK2HFsDAcgzwUKWHyu91npQvyFRM1w@mail.gmail.com>
References: <20200703182010.1867-1-bruceshenzk@gmail.com>
 <CAKgT0Uc0sxRmADBozs3BvK2HFsDAcgzwUKWHyu91npQvyFRM1w@mail.gmail.com>
Message-ID: <CAHE_cOvFC4sjVvVuC-7A8Zqw6=uJP5AAUmZOk5sQ=7bD+ePpgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Jul 04, 2020 at 09:05:48AM -0700, Alexander Duyck wrote:
> The upper limitation for the size should be 2K or FM10K_RX_BUFSZ, not
> PAGE_SIZE. Otherwise you are still capable of going out of bounds
> because the offset is used within the page to push the start of the
> region up by 2K.
PAGE_SIZE can drop the warning, as the dma allocated size is PAGE_SIZE.

> If this is actually fixing the warning it makes me wonder if the code
> performing the check is broken itself since we would still be
> accessing outside of the accessible DMA range.
The unbounded size is only passed to fm10k_add_rx_frag, which expects
and checks size to be less than FM10K_RX_HDR_LEN which is 256.

In this way, any boundary between 256 and 4K should work. I could address
that with a second version.
