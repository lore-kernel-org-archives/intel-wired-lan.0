From: Tejun Heo <tj@kernel.org>
Date: Wed, 1 Jun 2016 14:46:02 -0400
Subject: [Intel-wired-lan] [PATCH] net: ethernet: intel: fm10k: Remove
	create_workqueue
In-Reply-To: <20160601154009.GA31043@Karyakshetra>
References: <20160601154009.GA31043@Karyakshetra>
Message-ID: <20160601184602.GE14868@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 01, 2016 at 09:10:09PM +0530, Bhaktipriya Shridhar wrote:
> alloc_workqueue replaces deprecated create_workqueue().
> 
> A dedicated workqueue has been used since the workitem (viz
> fm10k_service_task, which manages and runs other subtasks) is involved in
> normal device operation and requires forward progress under memory
> pressure.
> 
> create_workqueue has been replaced with alloc_workqueue with max_active
> as 0 since there is no need for throttling the number of active work
> items.
> 
> Since network devices may be used in memory reclaim path,
> WQ_MEM_RECLAIM has been set to guarantee forward progress.
> 
> flush_workqueue is unnecessary since destroy_workqueue() itself calls
> drain_workqueue() which flushes repeatedly till the workqueue
> becomes empty. Hence the call to flush_workqueue() has been dropped.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
