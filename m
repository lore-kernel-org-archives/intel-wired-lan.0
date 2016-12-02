From: Ruslan Nikolaev <ruslan@purestorage.com>
Date: Thu, 1 Dec 2016 16:42:17 -0800
Subject: [Intel-wired-lan] Question about ixgbe RESET due to lost link
Message-ID: <8DAE8844-E419-473E-9033-8CB3CAB0D3A5@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While working with ixgbe (PF) and dpdk (VF), I have noticed that sometimes we get ?Reset adapter? message 'due to lost link with pending Tx work?.

The problem is that when handling the VF reset message that arrives through a mailbox (in the corresponding dpdk handler), the link may already be down. Therefore, we are unable to properly reset the device. While looking at the ixgbe code, I have noticed that IXGBE_FLAG2_RESET_REQUESTED (in this case, set in ixgbe_watchdog_flush_tx) is checked in ixgbe_reset_subtask. The latter will only do anything if the link is not already down.

I guess, my question is why we are setting it when detecting that the link is down. It is going to be down anyway. Can the actual reset take place when the link is up again?

Thank you!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161201/466ceb23/attachment-0001.html>
