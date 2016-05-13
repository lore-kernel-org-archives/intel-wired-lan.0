From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 13 May 2016 09:46:37 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: take online CPU number as MQ
	max limit when alloc_etherdev_mq()
In-Reply-To: <1463118995-31763-1-git-send-email-ethan.zhao@oracle.com>
References: <1463118995-31763-1-git-send-email-ethan.zhao@oracle.com>
Message-ID: <CAKgT0UeiEW21E7A9fnt_BUCppopns-E2w1WbwF-8A6sCZkJ8rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 12, 2016 at 10:56 PM, Ethan Zhao <ethan.zhao@oracle.com> wrote:
> Allocating 64 Tx/Rx as default doesn't benefit perfomrnace when less
> CPUs were assigned. especially when DCB is enabled, so we should take
> num_online_cpus() as top limit, and aslo to make sure every TC has
> at least one queue, take the MAX_TRAFFIC_CLASS as bottom limit of queues
> number.
>
> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>

What is the harm in allowing the user to specify up to 64 queues if
they want to?  Also what is your opinion based on?  In the case of RSS
traffic the upper limit is only 16 on older NICs, but last I knew the
latest X550 can support more queues for RSS.  Have you only been
testing on older NICs or did you test on the latest hardware as well?

If you want to control the number of queues allocated in a given
configuration you should look at the code over in the ixgbe_lib.c, not
ixgbe_main.c.  All you are doing with this patch is denying the user
choice with this change as they then are not allowed to set more
queues.  Even if they find your decision was wrong for their
configuration.

- Alex
