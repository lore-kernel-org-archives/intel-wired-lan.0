From: Hao Sun <sunhao.th@gmail.com>
Date: Sun, 11 Apr 2021 11:18:48 +0800
Subject: [Intel-wired-lan] KCSAN: data-race in e1000_clean / e1000_xmit_frame
Message-ID: <CACkBjsbE4KecPhdr8X2LeDE+RgtUoZVkwtb0xkUk20gbJ+P6Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi:

When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
the Linux kernel, I found a data-race bug in e1000_clean /
e1000_xmit_frame, but I'm not sure about this.
Sorry, data-race is usually difficult to reproduce. I cannot provide
you with a reproducing program.
I hope that the stack trace information in the crash log can help you
locate the problem.
Kernel config and full log can be found in the attachment.

Here is the detail:
commit:   3b9cdafb5358eb9f3790de2f728f765fef100731
version:   linux 5.11
git tree:    upstream

==================================================================
BUG: KCSAN: data-race in e1000_clean / e1000_xmit_frame

write to 0xffffc90000c81592 of 2 bytes by task 8373 on cpu 1:
 e1000_xmit_frame+0x1270/0x2900
 xmit_one+0xf9/0x2e0
 dev_hard_start_xmit+0x60/0x100
 sch_direct_xmit+0x170/0x730
 __qdisc_run+0x119/0x180
 __dev_queue_xmit+0xa55/0x1520
 dev_queue_xmit+0x13/0x20
 ip_finish_output2+0xb09/0xba0
 __ip_finish_output+0x2ce/0x430
 ip_finish_output+0x39/0x160
 ip_output+0xf6/0x1a0
 __ip_queue_xmit+0x9ca/0x9f0
 ip_queue_xmit+0x34/0x40
 __tcp_transmit_skb+0x12b6/0x18f0
 __tcp_send_ack+0x1e9/0x2e0
 tcp_send_ack+0x23/0x30
 tcp_cleanup_rbuf+0x1c4/0x310
 tcp_recvmsg_locked+0x1119/0x16f0
 tcp_recvmsg+0x145/0x430
 inet_recvmsg+0xa3/0x210
 sock_read_iter+0x19e/0x1e0
 vfs_read+0x552/0x5c0
 ksys_read+0xce/0x180
 __x64_sys_read+0x3e/0x50
 do_syscall_64+0x39/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffffc90000c81592 of 2 bytes by interrupt on cpu 0:
 e1000_clean+0xb6/0x1f10
 __napi_poll+0x77/0x510
 net_rx_action+0x29f/0x670
 __do_softirq+0x13c/0x2c8
 asm_call_irq_on_stack+0xf/0x20
 do_softirq_own_stack+0x32/0x40
 __irq_exit_rcu+0xb4/0xc0
 common_interrupt+0xbd/0x140
 asm_common_interrupt+0x1e/0x40
 kcsan_setup_watchpoint+0x44e/0x490
 handle_mm_fault+0x2ac/0x17b0
 do_user_addr_fault+0x60c/0xc00
 exc_page_fault+0x94/0x290
 asm_exc_page_fault+0x1e/0x30
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 220871 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210411/e8bbc9da/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: log
Type: application/octet-stream
Size: 7500 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210411/e8bbc9da/attachment-0003.obj>
