From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:26:54 +0000
Subject: [Intel-wired-lan] [next PATCH v5 03/12] igb: Clear Rx
 buffer_info in configure instead of clean
In-Reply-To: <20170207022547.9864.60500.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022547.9864.60500.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB35@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:26 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 03/12] igb: Clear Rx buffer_info in
> configure instead of clean
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change makes it so that instead of going through the entire ring on Rx
> cleanup we only go through the region that was designated to be cleaned up
> and stop when we reach the region where new allocations should start.
> 
> In addition we can avoid having to perform a memset on the Rx buffer_info
> structures until we are about to start using the ring again.  By deferring
> this we can avoid dirtying the cache any more than we have to which can
> help to improve the time needed to bring the interface down and then back
> up again in a reset or suspend/resume cycle.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
