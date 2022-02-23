From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 23 Feb 2022 17:44:12 +0100
Subject: [Intel-wired-lan] [PATCH net v1 1/8] iavf: Rework mutexes for
 better synchronisation
In-Reply-To: <20220223123549.29391-1-mateusz.palczewski@intel.com>
References: <20220223123549.29391-1-mateusz.palczewski@intel.com>
Message-ID: <20220223164412.289710-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 23 Feb 2022 13:35:49 +0100

First of all, please check your git-send-email settings.
Your patches don't have "In-Reply-To" and "References" headers,
which mean that they won't be represented as a series in Patchwork
and as an e-mail thread in list archivies or just mailboxes.
All the patches should have the ID of the cover letter (which I
haven't received at all, did you compose it?) in both headers to
be correctly represented.

> From: SlawomirX Laba <slawomirx.laba@intel.com>

"Slawomir" with no X I guess?
It's currently inconsistent with the Signed-off-by, and generally
people outside Intel don't know (and shouldn't care) what this X
does mean.
So please fix in v2.

> 
> The driver used to crash in multiple spots when put to stress testing
> of the init, reset and remove paths.
> 
> The user would experience call traces or hangs when creating,
> resetting, removing VFs. Depending on the machines, the call traces
> are happening in random spots, like reset restoring resources racing
> with driver remove.
> 
> Make adapter->crit_lock mutex a mandatory lock for guarding the
> operations performed on all workqueues and functions dealing with
> resource allocation and disposal.
> 
> Make __IAVF_REMOVE a final state of the driver respected by
> workqueues that shall not requeue, when they fail to obtain the
> crit_lock.
> 
> Make the IRQ handler not to queue the new work for adminq_task
> when the __IAVF_REMOVE state is set.
> 
> Fixes: 5ac49f3c2702 ("iavf: use mutexes for locking of critical sections")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>

Here's a correct signature for the reference.

> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  1 -
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 66 +++++++++++----------
>  2 files changed, 36 insertions(+), 31 deletions(-)
> 

--- 8< ---

> -- 
> 2.27.0

Thanks,
Al
