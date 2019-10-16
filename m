From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:22:22 +0000
Subject: [Intel-wired-lan] [PATCH S31 09/15] ice: Check for null pointer
 dereference when setting rings
In-Reply-To: <20191009140953.14087-9-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-9-anthony.l.nguyen@intel.com>
Message-ID: <cd6911ded035452390f56ac1aeb146e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 09/15] ice: Check for null pointer
> dereference when setting rings
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Without this check rebuild vsi can lead to kernel panic.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


