From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:08 +0000
Subject: [Intel-wired-lan] [PATCH S37 04/15] ice: Don't allow same value
 for Rx tail to be written twice
In-Reply-To: <20200122152041.41498-4-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-4-anthony.l.nguyen@intel.com>
Message-ID: <54797640ddcd49f2b5ae46d5a17a6acf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 04/15] ice: Don't allow same value for
> Rx tail to be written twice
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


