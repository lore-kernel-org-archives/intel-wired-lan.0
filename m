From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 21 Feb 2019 10:20:20 +0100
Subject: [Intel-wired-lan] [PATCH RFC 5/5] rcuwait: Replace
 rcu_assign_pointer() with WRITE_ONCE
In-Reply-To: <20190221054942.132388-6-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-6-joel@joelfernandes.org>
Message-ID: <20190221092020.GZ32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 21, 2019 at 12:49:42AM -0500, Joel Fernandes (Google) wrote:
> This suppresses a sparse error generated due to the recently added
> rcu_assign_pointer sparse check below. It seems WRITE_ONCE should be
> sufficient here.
> 
> >> kernel//locking/percpu-rwsem.c:162:9: sparse: error: incompatible
> types in comparison expression (different address spaces)
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/rcuwait.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
> index 90bfa3279a01..9e5b4760e6c2 100644
> --- a/include/linux/rcuwait.h
> +++ b/include/linux/rcuwait.h
> @@ -44,7 +44,7 @@ extern void rcuwait_wake_up(struct rcuwait *w);
>  	 */                                                             \
>  	WARN_ON(current->exit_state);                                   \
>  									\
> -	rcu_assign_pointer((w)->task, current);				\
> +	WRITE_ONCE((w)->task, current);					\
>  	for (;;) {							\
>  		/*							\
>  		 * Implicit barrier (A) pairs with (B) in		\

Distinct lack of justification for loosing the RELEASE again.
