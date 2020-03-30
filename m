From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 31 Mar 2020 00:13:05 +0900
Subject: [Intel-wired-lan] kernel panic: smack: Failed to initialize
 cipso DOI.
In-Reply-To: <000000000000db448f05a212beea@google.com>
References: <000000000000db448f05a212beea@google.com>
Message-ID: <a293a766-4329-f6de-c8a9-1a5051217c45@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020/03/30 22:51, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14957099e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
> dashboard link: https://syzkaller.appspot.com/bug?extid=89731ccb6fec15ce1c22
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1202c375e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1390bb03e00000

Wrong bisection. This is not a network / driver problem.
There is a memory allocation fault injection prior to this panic.

  [ T1576] FAULT_INJECTION: forcing a failure.
  [ T1576] Kernel panic - not syncing: smack:  Failed to initialize cipso DOI.
