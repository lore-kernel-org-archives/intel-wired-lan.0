From: syzbot <syzbot+554266c04a41d1f9754d@syzkaller.appspotmail.com>
Date: Sat, 13 Apr 2019 02:39:00 -0700
Subject: [Intel-wired-lan] general protection fault in requeue_rx_msgs
In-Reply-To: <0000000000000482ce056d7c1436@google.com>
Message-ID: <0000000000006a8b3505866630b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

syzbot has bisected this bug to:

commit 11a350c965cc5ac2f5d0ed1fb336735a0c1a6344
Author: Alan Brady <alan.brady@intel.com>
Date:   Fri Dec 29 13:48:33 2017 +0000

     i40e: fix typo in function description

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1534b397200000
start commit:   0044cdeb Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1734b397200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1334b397200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
dashboard link: https://syzkaller.appspot.com/bug?extid=554266c04a41d1f9754d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131a208f800000

Reported-by: syzbot+554266c04a41d1f9754d at syzkaller.appspotmail.com
Fixes: 11a350c965cc ("i40e: fix typo in function description")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
