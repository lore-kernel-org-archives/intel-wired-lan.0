From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:32:34 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 04/15] ice: Don't allow same
 value for Rx tail to be written twice
In-Reply-To: <20200206092013.23388-4-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-4-anthony.l.nguyen@intel.com>
Message-ID: <b9ba9ce6baff48398dd74fc8af301798@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 04/15] ice: Don't allow same value
> for Rx tail to be written twice
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we compare the value we are about to write to the Rx tail register
> with the previous value of next_to_use. The problem with this is we only
> write tail on 8 descriptor boundaries, but next_to_use is updated whenever
> we clean Rx descriptors. Fix this by comparing the value we are about to
> write to tail with the previously written tail value. This will prevent duplicate
> Rx tail bumps.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


