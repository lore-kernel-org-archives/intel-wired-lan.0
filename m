From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 17 Mar 2020 21:34:01 +0800
Subject: [Intel-wired-lan] [Regression] "e1000e: Add support for S0ix"
 breaks s2idle on Lenovo X1 Carbon 7th
Message-ID: <0A7D1E37-88A4-4E5A-8522-B80A8AE679EE@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Users reported that X1 Carbon 7th can only suspend once due of "e1000e 0000:00:1f.6 enp0s31f6: Hardware Error" [1] [2].
I managed to get one at hand and I can confirm the issue is 100% reproducible.

The error occurs at the first e1e_rphy() in e1000_copper_link_setup_82577() [3].

Reverting "e1000e: Add support for S0ix" makes suspend work again.
I also tried commit e1738282f6c6 "e1000e: fix S0ix flows for cable connected case" however the issue persists.

Kai-Heng

[1] https://bugs.launchpad.net/bugs/1865570
[2] https://bugs.launchpad.net/bugs/1866170
[3] https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/tree/drivers/net/ethernet/intel/e1000e/phy.c?h=dev-queue&id=e1738282f6c6ad0ec56a15c4d5a3b657d90e4435#n630
