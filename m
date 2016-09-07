From: Ruslan Nikolaev <ruslan@purestorage.com>
Date: Wed, 7 Sep 2016 16:52:01 -0700
Subject: [Intel-wired-lan] Question about 4 TX/RX queues and ixgbe
Message-ID: <A5A784DD-DB62-4511-8D8C-0A1CBCC23250@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I just want to follow up on the question regarding 2 queues per VF limit in IXGBE. According to the reply by Donald, it seems like the limit is due to limited number of interrupts, however:

1. Why is it allowed to use 4 TX/RX queues per VF if RSS (for the physical function) > 4? The condition in the code to enable 2-queue mode is only when rss_i < 4.
2. We do not necessarily need separate interrupts for RX, we just need 4 TX but are going to use just one 1 RX. Is it still a problem to use the proposed change?

Thank you!
Ruslan
