From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Sep 2017 00:18:47 +0000
Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: Fix error path in
	link	detection
In-Reply-To: <20170721183627.13373-1-bpoirier@suse.com>
References: <20170721160937.GA22632@csclub.uwaterloo.ca>
 <20170721183627.13373-1-bpoirier@suse.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6A059F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Benjamin Poirier
> Sent: Friday, July 21, 2017 11:36 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: Fix error path in link detection
> 
> In case of error from e1e_rphy(), the loop will exit early and "success"
> will be set to true erroneously.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/phy.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
