From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:48:35 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: initialize ITRN registers with
 correct values
In-Reply-To: <20191105122214.50556-1-alice.michael@intel.com>
References: <20191105122214.50556-1-alice.michael@intel.com>
Message-ID: <8163697827d8482986fab8950222ea07@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 5, 2019 4:22 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] iavf: initialize ITRN registers with correct
> values
> 
> From: Nicholas Nunley <nicholas.d.nunley@intel.com>
> 
> Since commit 92418fb14750 ("i40e/i40evf: Use usec value instead of reg value
> for ITR defines") the driver tracks the interrupt throttling intervals in single
> usec units, although the actual ITRN registers are programmed in 2 usec
> units. Most register programming flows in the driver correctly handle the
> conversion, although it is currently not applied when the registers are
> initialized to their default values. Most of the time this doesn't present a
> problem since the default values are usually immediately overwritten
> through the standard adaptive throttling mechanism, or updated manually by
> the user, but if adaptive throttling is disabled and the interval values are left
> alone then the incorrect value will persist.
> 
> Since the intended default interval of 50 usecs (vs. 100 usecs as
> programmed) performs better for most traffic workloads, this can lead to
> performance regressions.
> 
> This patch adds the correct conversion when writing the initial values to the
> ITRN registers.
> 
> Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


