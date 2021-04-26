From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Mon, 26 Apr 2021 16:15:08 +0200
Subject: [Intel-wired-lan] [PATCH net v2] igb: Fix XDP with PTP enabled
In-Reply-To: <CAMfj=-YEh1ZnLB8zye7i-5Y2S015n0qat+FQ6JW7bFKwBUHBPg@mail.gmail.com>
References: <CAMfj=-YEh1ZnLB8zye7i-5Y2S015n0qat+FQ6JW7bFKwBUHBPg@mail.gmail.com>
Message-ID: <871rax9loz.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun Apr 25 2021, Tyler S wrote:
> Thanks for this work; I was having trouble using XDP on my I354 NIC until this.
>
> Hopefully I have not err'd backporting it to 5.10 -- but I'm seeing
> jumbo frames dropped after applying this (though as previously
> mentioned, non-skb/full driver XDP programs do now work).
>
> Looking at the code, I'm not sure why that is.

I'm also not sure, yet.

Can you try with version 3 of this patch [1] and see if there are still
issues with jumbo frames? Can you also share the backported patch for
v5.10?

Thanks,
Kurt

[1] - https://lkml.kernel.org/netdev/20210422052617.17267-1-kurt at linutronix.de/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210426/9e7ca922/attachment.asc>
