From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 27 Jun 2018 09:30:51 +0800
Subject: [Intel-wired-lan] [BUG] net: e100: possible data races in
 e100_watchdog()
Message-ID: <ecf9293b-9105-8eb1-7184-77de6dd77786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The call paths in Linux 4.16.7 that may raise data races are:

CPU0:
e100_set_multicast_list
     e100_exec_cb
         line 879: spin_lock_irqsave()
         e100_configure
             line 1139: nic->flags [READ]
             line 1148: nic->flags [READ]

CPU1:
e100_watchdog:
     line 1758, 1756: nic->flags [WRITE]

The READ operations in CPU0 are performed with holding a spinlock (line 
879), but the WRITE operation in CPU1 is performed without holding this 
spinlock, so it may cause data races here.

A possible fix is to add spin_lock_irqsave() in e100_watchdog().
I am not sure that whether this possible fix is correct, so I only 
report the data races.


Best wishes,
Jia-Ju Bai
