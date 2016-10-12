From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 12 Oct 2016 16:03:39 +0000
Subject: [Intel-wired-lan] igb driver can cause cache invalidation of
	non-owned memory?
In-Reply-To: <CAKgT0UfPC_uAn5=+0iiAOGyY7QA-4NWAmedVmWf6TGnywjJR8A@mail.gmail.com>
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
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB01E6F0F@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck
> Sent: 12 October 2016 16:33
...
> > To get some throughput improvement, I propose removal of that
> > sync_for_device() before reusing buffer. Will you accept such a patch ;)
> 
> Not one that gets rid of sync_for_device() in the driver.  From what I
> can tell there are some DMA APIs that use that to perform the
> invalidation on the region of memory so that it can be DMAed into.
> Without that we run the risk of having a race between something the
> CPU might have placed in the cache and something the device wrote into
> memory.  The sync_for_device() call is meant to invalidate the cache
> for the region so that when the device writes into memory there is no
> risk of that race.

I'm not expert, but some thought...

Just remember that the cpu can do speculative memory and cache line reads.
So you need to ensure there are no dirty cache lines when the receive
buffer is setup and no cache lines at all at before looking at the frame.

So unless you know the exact rules for these speculative cache line reads
you have to invalidate the cache after the buffer is written to by the
hardware even it was invalidated when the buffer was set up.

If you can 100% guarantee the cpu hasn't dirtied the cache then I
think the invalidate prior to reusing the buffer can be skipped.
But I wouldn't want to debug that going wrong.
Might be provable safe in the 'copybreak' path.

	David

