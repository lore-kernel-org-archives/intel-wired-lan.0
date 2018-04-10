From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:12:10 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 01/10] ixgbe: Drop
 support for macvlan specific unicast lists
In-Reply-To: <20180403211558.7880.71817.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211558.7880.71817.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AECF@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 01/10] ixgbe: Drop support
> for macvlan specific unicast lists
> 
> Drop the code for handling macvlan specific unicast lists. It isn't needed since
> we don't take any efforts to maintain it when we bring the interface up and it
> takes the slow path anyway.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   31 -------------------------
>  1 file changed, 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


