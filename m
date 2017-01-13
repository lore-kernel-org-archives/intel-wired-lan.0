From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 12 Jan 2017 17:15:30 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Invoke softirqs after
	napi_reschedule
In-Reply-To: <20170113010414.22708-1-bpoirier@suse.com>
References: <20170113010414.22708-1-bpoirier@suse.com>
Message-ID: <1484270130.13165.15.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-01-12 at 17:04 -0800, Benjamin Poirier wrote:
> The following message is logged from time to time when using i40e:
> NOHZ: local_softirq_pending 08
> 
> i40e may schedule napi from a workqueue. Afterwards, softirqs are not run
> in a deterministic time frame. The problem is the same as what was
> described in commit ec13ee80145c ("virtio_net: invoke softirqs after
> __napi_schedule") and this patch applies the same fix to i40e.

Yes, I believe mlx4 has a similar problem in mlx4_en_recover_from_oom()


