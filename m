From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 16 Mar 2021 10:14:43 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: fix locking of critical sections
In-Reply-To: <20210316100141.53551-1-sassmann@kpanic.de>
References: <20210316100141.53551-1-sassmann@kpanic.de>
Message-ID: <20210316101443.56b87cf6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 16 Mar 2021 11:01:41 +0100 Stefan Assmann wrote:
> To avoid races between iavf_init_task(), iavf_reset_task(),
> iavf_watchdog_task(), iavf_adminq_task() as well as the shutdown and
> remove functions more locking is required.
> The current protection by __IAVF_IN_CRITICAL_TASK is needed in
> additional places.
> 
> - The reset task performs state transitions, therefore needs locking.
> - The adminq task acts on replies from the PF in
>   iavf_virtchnl_completion() which may alter the states.
> - The init task is not only run during probe but also if a VF gets stuck
>   to reinitialize it.
> - The shutdown function performs a state transition.
> - The remove function perorms a state transition and also free's
>   resources.
> 
> iavf_lock_timeout() is introduced to avoid waiting infinitely
> and cause a deadlock. Rather unlock and print a warning.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

I personally think that the overuse of flags in Intel drivers brings
nothing but trouble. At which point does it make sense to just add a
lock / semaphore here rather than open code all this with no clear
semantics? No code seems to just test the __IAVF_IN_CRITICAL_TASK flag,
all the uses look like poor man's locking at a quick grep. What am I
missing?
