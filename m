From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Nov 2018 16:54:10 +0000
Subject: [Intel-wired-lan] [PATCH tip/core/rcu 13/41]
 ethernet/intel/ixgbe: Replace synchronize_sched() with synchronize_rcu()
In-Reply-To: <20181111194410.6368-13-paulmck@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-13-paulmck@linux.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32A057@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul E. McKenney
> Sent: Sunday, November 11, 2018 11:44 AM
> To: linux-kernel at vger.kernel.org
> Cc: tglx at linutronix.de; David S. Miller <davem@davemloft.net>;
> peterz at infradead.org; fweisbec at gmail.com; jiangshanlai at gmail.com;
> josh at joshtriplett.org; rostedt at goodmis.org; oleg at redhat.com;
> dhowells at redhat.com; edumazet at google.com;
> mathieu.desnoyers at efficios.com; dipankar at in.ibm.com;
> joel at joelfernandes.org; intel-wired-lan at lists.osuosl.org; akpm at linux-
> foundation.org; Paul E. McKenney <paulmck@linux.ibm.com>;
> mingo at kernel.org
> Subject: [Intel-wired-lan] [PATCH tip/core/rcu 13/41] ethernet/intel/ixgbe:
> Replace synchronize_sched() with synchronize_rcu()
> 
> Now that synchronize_rcu() waits for preempt-disable regions of code as
> well as RCU read-side critical sections, synchronize_sched() can be replaced
> by synchronize_rcu().  This commit therefore makes this change.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <intel-wired-lan@lists.osuosl.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


