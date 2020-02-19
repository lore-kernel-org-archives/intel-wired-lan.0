From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:42:43 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 11/15] ice: increase PF reset
 wait timeout to 300 milliseconds
In-Reply-To: <20200213213129.34023-10-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-10-anthony.l.nguyen@intel.com>
Message-ID: <bf67d5df5fa842df82e2349b94042622@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 11/15] ice: increase PF reset wait
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


