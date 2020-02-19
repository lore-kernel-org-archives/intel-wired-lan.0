From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:40:12 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 06/15] ice: Report correct DCB
 mode
In-Reply-To: <20200213213129.34023-5-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-5-anthony.l.nguyen@intel.com>
Message-ID: <85928f958dde436a9dfd79ce9b8b0e13@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S39 v2 06/15] ice: Report correct DCB mode
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> Add code to detect if DCB is in IEEE or CEE mode. Without this the code will
> always report as IEEE mode which is incorrect and confuses the user.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Signed-off-by: Scott Register <scottx.register@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 27 +++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


