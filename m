From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:12:52 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 02/10] macvlan: Rename
 fwd_priv to accel_priv and add accessor function
In-Reply-To: <20180403211603.7880.2593.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211603.7880.2593.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AEDF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, April 3, 2018 2:16 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 02/10] macvlan: Rename
> fwd_priv to accel_priv and add accessor function
> 
> This change renames the fwd_priv member to accel_priv as this more
> accurately reflects the actual purpose of this value. In addition I am adding an
> accessor which will allow us to further abstract this in the future if needed.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   10 +++-----
>  drivers/net/macvlan.c                         |   31 +++++++++++++++----------
>  include/linux/if_macvlan.h                    |    8 ++++++
>  3 files changed, 30 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


