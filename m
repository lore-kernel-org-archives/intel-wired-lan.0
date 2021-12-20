From: syzbot <syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com>
Date: Sun, 19 Dec 2021 20:15:07 -0800
Subject: [Intel-wired-lan] [syzbot] kernel BUG in pskb_expand_head
In-Reply-To: <0000000000007ea16705d0cfbb53@google.com>
Message-ID: <000000000000413eba05d38c22c2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

syzbot has bisected this issue to:

commit e4b8954074f6d0db01c8c97d338a67f9389c042f
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Dec 7 01:30:37 2021 +0000

    netlink: add net device refcount tracker to struct ethnl_req_info

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=109e6fcbb00000
start commit:   434ed2138994 Merge branch 'tc-action-offload'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=129e6fcbb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=149e6fcbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7488eea316146357
dashboard link: https://syzkaller.appspot.com/bug?extid=4c63f36709a642f801c5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14141ca3b00000

Reported-by: syzbot+4c63f36709a642f801c5 at syzkaller.appspotmail.com
Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
