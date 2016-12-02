From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Dec 2016 18:13:41 -0800
Subject: [Intel-wired-lan] Question about ixgbe RESET due to lost link
In-Reply-To: <8DAE8844-E419-473E-9033-8CB3CAB0D3A5@purestorage.com>
References: <8DAE8844-E419-473E-9033-8CB3CAB0D3A5@purestorage.com>
Message-ID: <CAKgT0UdOoTn77DM_KHkS=tkDW19dxJGrSUv9tn=ZvGy+bR=Dcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Dec 1, 2016 at 4:42 PM, Ruslan Nikolaev <ruslan@purestorage.com> wrote:
> While working with ixgbe (PF) and dpdk (VF), I have noticed that sometimes
> we get ?Reset adapter? message 'due to lost link with pending Tx work?.
>
> The problem is that when handling the VF reset message that arrives through
> a mailbox (in the corresponding dpdk handler), the link may already be down.
> Therefore, we are unable to properly reset the device. While looking at the
> ixgbe code, I have noticed that IXGBE_FLAG2_RESET_REQUESTED (in this case,
> set in ixgbe_watchdog_flush_tx) is checked in ixgbe_reset_subtask. The
> latter will only do anything if the link is not already down.

Why can't you properly reset the device?  The PF should have already
taken care of resetting the queues when it did the reset itself.  All
that should be left to do is for the VF to reinitialize the queues so
that they are re-enabled after the reset.

> I guess, my question is why we are setting it when detecting that the link
> is down. It is going to be down anyway. Can the actual reset take place when
> the link is up again?
>
> Thank you!

The short answer to this is "no".

What it all comes down to is that we have to flush the Tx queues when
the link goes down to get rid of stale data.  We need to go through
and clean out the Tx rings so that the Tx and Rx FIFOs are cleared and
ready to go when the link comes back up.  We can't reset the part
after link up because by that point the link has already come back up
and the stale data is likely already moving through queues.
