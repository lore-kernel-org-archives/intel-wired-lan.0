From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:52:13 +0000
Subject: [Intel-wired-lan] [PATCH S39 11/15] ice: increase PF reset wait
 timeout to 300 milliseconds
In-Reply-To: <20200127085927.13999-11-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-11-anthony.l.nguyen@intel.com>
Message-ID: <108bfa32a06744f59fecce107306dd68@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 11/15] ice: increase PF reset wait
> timeout to 300 milliseconds
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Increase the maximum time that the driver will wait for a PF reset from
> 200 milliseconds to 300 milliseconds, to account for possibility of a slightly
> longer than expected PF reset.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


