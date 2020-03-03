From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:09:14 +0000
Subject: [Intel-wired-lan] [PATCH S40 12/15] ice: Fix format specifier
In-Reply-To: <20200227181505.61720-12-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-12-anthony.l.nguyen@intel.com>
Message-ID: <90e3c6ccc41f4d8e8167f64ce8babc33@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 12/15] ice: Fix format specifier
> 
> Commit ed5a3f664c55 ("ice: Removing hung_queue variable to use txqueue
> function parameter") began utilizing the txqueue variable over the
> hung_queue variable. hung_queue was an int where txqueue is an unsigned
> int. Update the format specfiers to reflect the new type.
> 
> Fixes: ed5a3f664c55 ("ice: Removing hung_queue variable to use txqueue
> function parameter")
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


