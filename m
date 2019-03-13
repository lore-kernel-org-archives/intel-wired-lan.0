From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Wed, 13 Mar 2019 12:23:13 +0100
Subject: [Intel-wired-lan] [bpf-next, 02/11] xsk: introduce xdp_umem_page
In-Reply-To: <c1cb2ca8-6a14-3980-8672-f3de0bb38dfd@suse.cz>
References: <20180604120601.18123-3-bjorn.topel@gmail.com>
 <c1cb2ca8-6a14-3980-8672-f3de0bb38dfd@suse.cz>
Message-ID: <d0c5ba60-cc34-7d30-e513-aa85f03ed5ac@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-03-13 10:39, Jiri Slaby wrote:
> On 04. 06. 18, 14:05, Bj?rn T?pel wrote:
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>> 
>> The xdp_umem_page holds the address for a page. Trade memory for 
>> faster lookup. Later, we'll add DMA address here as well.
> ...
>> --- a/include/net/xdp_sock.h +++ b/include/net/xdp_sock.h
> ...
>> --- a/net/xdp/xdp_umem.c +++ b/net/xdp/xdp_umem.c @@ -65,6 +65,9 @@
>> static void xdp_umem_release(struct xdp_umem *umem) goto out;
>> 
>> mmput(mm); +	kfree(umem->pages); +	umem->pages = NULL; +
> 
> Are you sure about the placement of kfree here? Why is it dependent
> on task && mm above?
> 
> IMO the kfree should be below "out:":
> 
>> xdp_umem_unaccount_pages(umem); out: kfree(umem);
> Syzkaller reported this memleak: r0 = socket$xdp(0x2c, 0x3, 0x0) 
> setsockopt$XDP_UMEM_REG(r0, 0x11b, 0x4, 
> &(0x7f0000000100)={&(0x7f0000000000)=""/210, 0x20000, 0x1000, 0x7},
> 0x18) BUG: memory leak unreferenced object 0xffff88003648de68 (size
> 512): comm "syz-executor.3", pid 11688, jiffies 4295555546 (age
> 15.752s) hex dump (first 32 bytes): 00 00 40 23 00 88 ff ff 00 00 00
> 00 00 00 00 00  ..@#............ 00 10 40 23 00 88 ff ff 00 00 00 00
> 00 00 00 00  ..@#............ backtrace: [<ffffffffa9f8346c>]
> xsk_setsockopt+0x40c/0x510 net/xdp/xsk.c:539 [<ffffffffa9935c41>]
> SyS_setsockopt+0x171/0x370 net/socket.c:1862 [<ffffffffa800b28c>]
> do_syscall_64+0x26c/0x6e0 arch/x86/entry/common.c:284 
> [<ffffffffaa00009a>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2 
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> 
> Given the size of the leak, it looks like umem->pages is leaked: 
> mr->len/page_size*sizeof(*umem->pages) 0x20000/4096*16=512
> 
> So I added a check, and really, task is NULL in my testcase -- the 
> program is gone when the deferred work triggers. But umem->pages is
> not freed.
> 
> Moving the free after "out:", no leaks happen anymore.
> 
> Easily reproducible with: #include <err.h> #include <stdlib.h> 
> #include <unistd.h>
> 
> #include <sys/socket.h> #include <sys/types.h> #include <sys/wait.h>
> 
> #include <linux/if_xdp.h>
> 
> void fun() { static char buffer[0x20000]
> __attribute__((aligned(4096))); struct xdp_umem_reg mr = { (unsigned
> long)buffer, 0x20000, 0x1000, 0x7, 
> //&(0x7f0000000100)={&(0x7f0000000000)=""/210, 0x20000, 0x1000, 0x7} 
> }; int r0; r0 = socket(AF_XDP, SOCK_RAW, 0); if (r0 < 0) err(1,
> "socket"); if (setsockopt(r0, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr))
> < 0) err(1, "setsockopt"); close(r0); }
> 
> int main() { int a; while (1) { for (a = 0; a < 40; a++) if (!fork())
> { fun(); exit(0); } for (a = 0; a < 100; a++) wait(NULL); } }
> 
> 
> thanks,
> 

Nice catch, Jiri! Thank you!

It turns out that the whole task/pid dance is useless. It was a
left-over from the first AF_XDP RFC when we did per task accounting,
instead of per user accounting.

I will do some testing with the patch below, and then submit it as a
proper patch.


Cheers,
Bj?rn

--

From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Wed, 13 Mar 2019 12:00:51 +0100
Subject: [PATCH] xsk: fix umem memory leak on cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the umem is cleaned up, the task that created it might already be
gone. If the task was gone, the xdp_umem_release function did not free
the pages member of struct xdp_umem.

It turned out that the task lookup was not needed at all; The code was
a left-over when we moved from task accounting to user accounting [1].

This patch fixes the memory leak by removing the task lookup logic
completely.

[1] 
https://lore.kernel.org/netdev/20180131135356.19134-3-bjorn.topel at gmail.com/

Link: 
https://lore.kernel.org/netdev/c1cb2ca8-6a14-3980-8672-f3de0bb38dfd at suse.cz/
Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
  include/net/xdp_sock.h |  1 -
  net/xdp/xdp_umem.c     | 19 +------------------
  2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 61cf7dbb6782..d074b6d60f8a 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -36,7 +36,6 @@ struct xdp_umem {
  	u32 headroom;
  	u32 chunk_size_nohr;
  	struct user_struct *user;
-	struct pid *pid;
  	unsigned long address;
  	refcount_t users;
  	struct work_struct work;
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 77520eacee8f..989e52386c35 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -193,9 +193,6 @@ static void xdp_umem_unaccount_pages(struct xdp_umem 
*umem)

  static void xdp_umem_release(struct xdp_umem *umem)
  {
-	struct task_struct *task;
-	struct mm_struct *mm;
-
  	xdp_umem_clear_dev(umem);

  	ida_simple_remove(&umem_ida, umem->id);
@@ -214,21 +211,10 @@ static void xdp_umem_release(struct xdp_umem *umem)

  	xdp_umem_unpin_pages(umem);

-	task = get_pid_task(umem->pid, PIDTYPE_PID);
-	put_pid(umem->pid);
-	if (!task)
-		goto out;
-	mm = get_task_mm(task);
-	put_task_struct(task);
-	if (!mm)
-		goto out;
-
-	mmput(mm);
  	kfree(umem->pages);
  	umem->pages = NULL;

  	xdp_umem_unaccount_pages(umem);
-out:
  	kfree(umem);
  }

@@ -357,7 +343,6 @@ static int xdp_umem_reg(struct xdp_umem *umem, 
struct xdp_umem_reg *mr)
  	if (size_chk < 0)
  		return -EINVAL;

-	umem->pid = get_task_pid(current, PIDTYPE_PID);
  	umem->address = (unsigned long)addr;
  	umem->chunk_mask = ~((u64)chunk_size - 1);
  	umem->size = size;
@@ -373,7 +358,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, 
struct xdp_umem_reg *mr)

  	err = xdp_umem_account_pages(umem);
  	if (err)
-		goto out;
+		return err;

  	err = xdp_umem_pin_pages(umem);
  	if (err)
@@ -392,8 +377,6 @@ static int xdp_umem_reg(struct xdp_umem *umem, 
struct xdp_umem_reg *mr)

  out_account:
  	xdp_umem_unaccount_pages(umem);
-out:
-	put_pid(umem->pid);
  	return err;
  }

-- 
2.19.1




