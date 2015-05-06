From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 May 2015 22:46:07 +0000
Subject: [Intel-wired-lan] [PATCH v2 3/3] ixgbe: Don't report flow
 director	filter's status
In-Reply-To: <1430276261-29821-4-git-send-email-fan.du@intel.com>
References: <1430276261-29821-1-git-send-email-fan.du@intel.com>
 <1430276261-29821-4-git-send-email-fan.du@intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F8289DA@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Fan Du
> Sent: Tuesday, April 28, 2015 7:58 PM
> To: Kirsher, Jeffrey T
> Cc: netdev at vger.kernel.org; Du, Fan; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 3/3] ixgbe: Don't report flow director filter's
> status
> 
> For two reasons I want to disable this:
> 1. Not any part actually check the report status(Alexander Duyck) 2. To report
> hash value of a packet to stack,
>    RSS -> 32bits hash value
>    Perfect match fdir filter -> 13bits hash value
>    Hashed-based fdir filter -> 31bits hash value
> 
>    fdir filter might hash on masked tuples for IP address,
>    so it's still not desirable for usage.
> 
> So for now, just stick to RSS 32bits hash value.
> 
> Signed-off-by: Fan Du <fan.du@intel.com>
> Suggested-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
