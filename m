From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 3 Oct 2018 21:03:38 +0800
Subject: [Intel-wired-lan] [REPORT] net: e100: possible data races
Message-ID: <8b3eba57-bdf3-3c0d-1889-12a971f277d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

CPU0:
e100_set_multicast_list
   e100_exec_cb
     line 854: spin_lock_irqsave()
     line 866: e100_configure (function pointer)
       line 1114: nic->flags [READ]
       line 1123: nic->flags [READ]

CPU1:
e100_watchdog
   line 1731: nic->flags [WRITE]
   line 1733: nic->flags [WRITE]

As for nic->flags, the WRITE operations in CPU0 are performed
with holding a spinlock, but the READ operations in CPU1 are performed
without holding this spinlock, so there may exist data races.

These possible races are detected by a runtime testing.
I do not find a good way to fix these races, so I only report them.


Best wishes,
Jia-Ju Bai
