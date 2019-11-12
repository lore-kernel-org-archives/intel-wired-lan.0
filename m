From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:36:55 +0000
Subject: [Intel-wired-lan] [PATCH S33 14/15] ice: remove pointless NULL
 check of port_info
In-Reply-To: <20191108142331.10221-14-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-14-anthony.l.nguyen@intel.com>
Message-ID: <4c7a341e7d5b4b459c3151e8772e8e16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 14/15] ice: remove pointless NULL
> check of port_info
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The code in ice_sched_cleanup_all checks whether the port info is NULL prior
> to calling ice_sched_clear_port. However, ice_sched_clear_port already
> checks whether port info is non-NULL.
> 
> More importantly, it also checks whether the port structure has been
> initialized by checking its port_state field as well.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


