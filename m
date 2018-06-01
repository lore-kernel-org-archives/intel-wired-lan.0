From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Jun 2018 17:25:56 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix possible race in reset
 subtask
In-Reply-To: <20180530160512.37220-1-anthony.l.nguyen@intel.com>
References: <20180530160512.37220-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C5D65@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, May 30, 2018 9:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix possible race in reset subtask
> 
> Similar to ixgbevf, the same possibility for race exists. Extend the RTNL lock in
> ixgbe_reset_subtask() to protect the state bits; this is to make sure that we
> get the most up-to-date values for the bits and avoid a possible race when
> going down.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


