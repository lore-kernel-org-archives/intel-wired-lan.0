From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 13 Oct 2016 10:39:52 +0000
Subject: [Intel-wired-lan] igb driver can cause cache invalidation of
	non-owned memory?
In-Reply-To: <CAKgT0UdMG4D8CZCVhBD7vF+E5aOk7zyPEp1xXaBukg3v0aYfFg@mail.gmail.com>
References: <0b57cbe2-84f7-6c0a-904a-d166571234b5@cogentembedded.com>
 <20161010.050125.1981283393312167625.davem@davemloft.net>
 <10474d19-df1a-3b09-917e-70659be3a56c@cogentembedded.com>
 <20161010.075731.2449861168238706.davem@davemloft.net>
 <f75cf1e1-d7e8-e044-188a-987f05f321a5@cogentembedded.com>
 <CAKgT0Uc2nL1aPoryhNxdbf3+TQO+fOvAZMZDe+=9NaqnHCZPyw@mail.gmail.com>
 <19aebfc3-5f1a-9206-4493-2255af7269f9@cogentembedded.com>
 <CAKgT0UcSkG1Nws1kcUp-QV0jnwdXcXrOZ2m0vsWRziETA-11sw@mail.gmail.com>
 <a0779e4d-3228-8649-1e68-21dffd4249bd@cogentembedded.com>
 <CAKgT0UfPC_uAn5=+0iiAOGyY7QA-4NWAmedVmWf6TGnywjJR8A@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DB01E6F0F@AcuExch.aculab.com>
 <cbd0f41d-bc01-3f93-9171-2795c61afdc9@cogentembedded.com>
 <CAKgT0UdqwpjP0b4knt2d4DqS1Z9dR+vg-smkgBTZDeACGGdx=Q@mail.gmail.com>
 <d34b7175-1024-8cc9-d422-d9f75f56c069@cogentembedded.com>
 <CAKgT0UdMG4D8CZCVhBD7vF+E5aOk7zyPEp1xXaBukg3v0aYfFg@mail.gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB01E773C@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck
> Sent: 12 October 2016 19:30
> On Wed, Oct 12, 2016 at 11:12 AM, Nikita Yushchenko
> <nikita.yoush@cogentembedded.com> wrote:
> >> It would make more sense to update the DMA API for
> >> __dma_page_cpu_to_dev on ARM so that you don't invalidate the cache if
> >> the direction is DMA_FROM_DEVICE.
> >
> > No, in generic case it's unsafe.
> >
> > If CPU issued a write to a location, and sometime later that location is
> > used as DMA buffer, there is danger that write is still in cache only,
> > and writeback is pending. Later this writeback can overwrite data
> > written to memory via DMA, causing corruption.
> 
> Okay so if I understand it correctly then the invalidation in
> sync_for_device is to force any writes to be flushed out, and the
> invalidation in sync_for_cpu is to flush out any speculative reads.
> So without speculative reads then the sync_for_cpu portion is not
> needed.  You might want to determine if the core you are using
> supports the speculative reads, if not you might be able to get away
> without having to do the sync_for_cpu at all.

For reads the sync_for_device invalidates (ie discards the contents of)
the cache lines to ensure the cpu won't write back dirty lines.
The sync_for_cpu invalidates the cache to ensure the cpu actually
reads from memory.

For writes you need to flush (write back) cache lines prior to the DMA.
I don't think anything is needed when the transfer finishes.

If headers/trailers might be added the sync_for_device must cover
the entire area the frame will be written to.
Clearly the sync_for_cpu need only cover the valid frame data.
I suspect you can safely skip the sync_for_device in the 'copybreak'
path but not if the frame is passed up the protocol stack.

	David

