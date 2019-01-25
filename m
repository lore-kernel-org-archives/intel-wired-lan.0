From: Ruhl, Michael J <michael.j.ruhl@intel.com>
Date: Fri, 25 Jan 2019 12:58:15 +0000
Subject: [Intel-wired-lan] FW: lock dep issue
In-Reply-To: <1EF4DF93-8A2A-41A0-BC2A-7604B59875A4@intel.com>
References: <14063C7AD467DE4B82DEDB5C278E8663BE656B4C@FMSMSX108.amr.corp.intel.com>
 <1EF4DF93-8A2A-41A0-BC2A-7604B59875A4@intel.com>
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663BE656FE3@FMSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

While running a 5.0.0.rc1 kernel with the LOCKDEP debug configuration turned on, and I saw this LOCKDEP error:

--
 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
 in_atomic(): 1, irqs_disabled(): 0, pid: 2583, name: sadc
 2 locks held by sadc/2583:
  #0: 00000000e5ef963c (&p->lock){+.+.}, at: seq_read+0x3c/0x3a0
  #1: 00000000f89a2b22 (rcu_read_lock){....}, at: dev_seq_start+0x5/0x110
 CPU: 29 PID: 2583 Comm: sadc Tainted: G        W I       5.0.0-rc1+ #2
 Hardware name: Intel Corporation S2600WT2/S2600WT2, BIOS SE5C610.86B.01.01.0008.021120151325 02/11/2015
 Call Trace:
  dump_stack+0x78/0xb3
  ___might_sleep+0x22d/0x250
  __mutex_lock+0x56/0x910
  ? _raw_spin_unlock+0x24/0x30
  ? deactivate_slab.isra.73+0x5b2/0x6f0
  ? igb_get_stats64+0x29/0xf0 
  ? seq_read+0x305/0x3a0
  ? set_track+0x6d/0x1a0
  igb_get_stats64+0x29/0xf0 
  dev_get_stats+0x74/0x130
  dev_seq_printf_stats+0x34/0x120
  ? __lock_acquire+0x69a/0x1160
  dev_seq_show+0x10/0x30
  seq_read+0x266/0x3a0
  proc_reg_read+0x3c/0x70
  __vfs_read+0x36/0x190
  vfs_read+0x9b/0x150
  ksys_read+0x55/0xc0
  do_syscall_64+0x60/0x210
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7f650013ec00
 Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 17 b9 09 00 e8 52 8a 02 00 66 90 83 3d 9d c3 2d 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e cc 01 00 48 89 04 24
 RSP: 002b:00007fffed163aa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000001f6b8b0 RCX: 00007f650013ec00
 RDX: 0000000000000400 RSI: 00007f650084a000 RDI: 0000000000000003
 RBP: 00007f65004123a0 R08: ffffffffffffffff R09: 0000000000000000
 R10: 0000000000000022 R11: 0000000000000246 R12: 00007f6500411858
 R13: 0000000000000d70 R14: 0000000000000d70 R15: 00007f6500411858
--

I saw this on the console while not doing anything on the system (i.e. no test were running, or any overt network work).

Since this didn't seem like a good thing I thought I would drop this  note.
 
If you need any more information, please let me know.

Thanks,

Mike

