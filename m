From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Mar 2018 18:13:37 +0000
Subject: [Intel-wired-lan] [PATCH 5/5] ixgbevf: Add XDP queue stats
 reporting
In-Reply-To: <20180316223406.7295-6-anthony.l.nguyen@intel.com>
References: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
 <20180316223406.7295-6-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94D29C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, March 16, 2018 3:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 5/5] ixgbevf: Add XDP queue stats
> reporting
> 
> XDP stats are included in TX stats, however, they are not reported in TX
> queue stats since they are setup on different queues.  Add reporting for XDP
> queue stats to provide consistency between the total stats and per queue
> stats.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c | 24
> ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


