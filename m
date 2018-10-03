From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 3 Oct 2018 21:18:41 +0800
Subject: [Intel-wired-lan] [REPORT] net: e1000e: possible data races
Message-ID: <1b02ad06-ff89-3540-ca85-17f826acfadc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

CPU0:
e1000e_get_stats64
     line 5944: spin_lock()
     e1000e_update_stats
         line 4949: hw->mac.tx_packet_delta = er32(TPT); [WRITE]

CPU1:
e1000_watchdog_task
     e1000e_update_adaptive
         line 1762: mac->tx_packet_delta [READ]
         line 1763: mac->tx_packet_delta [READ]
         line 1776: mac->tx_packet_delta [READ]

As for mac->tx_packet_delta, the WRITE operation in CPU0 is performed
with holding a spinlock, but the READ operations in CPU1 are performed
without holding this spinlock, so there may exist data races.

These possible races are detected by a runtime testing.
I do not find a good way to fix these races, so I only report them.


Best wishes,
Jia-Ju Bai
