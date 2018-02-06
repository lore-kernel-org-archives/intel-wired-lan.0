From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Feb 2018 22:34:03 +0000
Subject: [Intel-wired-lan] [next PATCH S86 V3 1/8] i40e: don't leak
 memory addresses
In-Reply-To: <20180205111121.59468-1-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A949911@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, February 5, 2018 3:11 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86 V3 1/8] i40e: don't leak memory
> addresses
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Could a Bad Person do Bad Things to a server if they found these addresses
> printed in the log? Who knows? But let's not take that risk.
> 
> Remove pointers from a bunch of printks. In some cases, I was able to adjust
> the mesasge to indicate whether or not the value was null. In others, I just
> removed the entire message as there was really no hope of saving it.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 40 ++++----------------------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 ++++-----
>  2 files changed, 12 insertions(+), 41 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


