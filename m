From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Sep 2019 20:37:01 +0000
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Prevent u8 wrapping
 of ITR value to something less than 10us
In-Reply-To: <20190904150703.13516.21103.stgit@localhost.localdomain>
References: <20190904150703.13516.21103.stgit@localhost.localdomain>
Message-ID: <2bdef38639cd416e8f6f2c84fb20a4b3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, September 4, 2019 8:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: alexander.h.duyck at linux.intel.com; gleventhal at janestreet.com
> Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Prevent u8 wrapping of
> ITR value to something less than 10us
> 
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> There were a couple cases where the ITR value generated via the adaptive
> ITR scheme could exceed 126. This resulted in the value becoming either 0 or
> something less than 10. Switching back and forth between a value less than
> 10 and a value greater than 10 can cause issues as certain hardware features
> such as RSC to not function well when the ITR value has dropped that low.
> 
> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


