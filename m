From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 20 Sep 2018 13:35:00 -0700
Subject: [Intel-wired-lan] [PATCH net] ixgbe: check return value of
 napi_complete_done()
In-Reply-To: <20180920190113.490005-1-songliubraving@fb.com>
References: <20180920190113.490005-1-songliubraving@fb.com>
Message-ID: <c1251d5d-4b18-a1de-acd2-6de829b7c7ac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 09/20/2018 12:01 PM, Song Liu wrote:
> The NIC driver should only enable interrupts when napi_complete_done()
> returns true. This patch adds the check for ixgbe.
> 
> Cc: stable at vger.kernel.org # 4.10+
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---


Well, unfortunately we do not know why this is needed,
this is why I have not yet sent this patch formally.

netpoll has correct synchronization :

poll_napi() places into napi->poll_owner current cpu number before calling poll_one_napi()

netpoll_poll_lock() does also use napi->poll_owner

When netpoll calls ixgbe poll() method, it passed a budget of 0,
meaning napi_complete_done() is not called.

As long as we can not explain the problem properly in the changelog,
we should investigate, otherwise we will probably see coming dozens of patches
trying to fix a 'potential hazard'.

Thanks.


