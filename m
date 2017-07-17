From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Jul 2017 18:22:51 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 09/11] i40e: force VMDQ
 device	name truncation
In-Reply-To: <20170712094614.76501-9-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
 <20170712094614.76501-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB1E4E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, July 12, 2017 2:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S75-V3 09/11] i40e: force VMDQ
> device name truncation
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In new versions of GCC since 7.x a new warning exists which warns when a
> string is truncated before all of the format can be completed.
> 
> When we setup VMDQ netdev names we are copying a pre-existing
> interface name which could be up to 15 characters in length. Since we also
> add
> 4 bytes, v, the literal %, the d and a \0 null, we would overrun the available
> size unless snprintf truncated for us.
> 
> The snprintf call will ofcourse truncate on the end, so lets instead modify the
> code to force truncation of the copied netdev name by
> 4 characters, to create enough space for the 4 bytes we're adding.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


