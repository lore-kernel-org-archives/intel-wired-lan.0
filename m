From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 5 Jan 2022 15:04:43 +0100
Subject: [Intel-wired-lan] [syzbot] kernel BUG in pskb_expand_head
In-Reply-To: <CANn89i+LbcWn3xoYU-eMjjmQPz0x1pSAat2OpF=i0+RByc-h4w@mail.gmail.com>
References: <0000000000007ea16705d0cfbb53@google.com>
 <000000000000c7845605d4d3f0a0@google.com>
 <CANn89i+LbcWn3xoYU-eMjjmQPz0x1pSAat2OpF=i0+RByc-h4w@mail.gmail.com>
Message-ID: <20220105140443.vwobz3yx4z3rux6a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05.01.2022 05:59:35, Eric Dumazet wrote:
> On Wed, Jan 5, 2022 at 3:20 AM syzbot
> <syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    c9e6606c7fe9 Linux 5.16-rc8
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=148351c3b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=32f9fa260d7413b4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4c63f36709a642f801c5
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15435e2bb00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f4508db00000
> >
> 
> This C repro looks legit, bug should be in CAN layer.

ACK - it's bug in CAN's ISOTP

> > The issue was bisected to:
> >
> > commit e4b8954074f6d0db01c8c97d338a67f9389c042f
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Tue Dec 7 01:30:37 2021 +0000
> >
> >     netlink: add net device refcount tracker to struct ethnl_req_info
> 
> Ignore this bisection, an unrelated commit whent in its way.

ACK - We have a RFC fix for this:

https://lore.kernel.org/all/20220105132429.1170627-1-mkl at pengutronix.de

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220105/1a7af409/attachment.asc>
