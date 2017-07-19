From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jul 2017 18:56:36 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 11/11] i40e: 25G FEC
 status	improvements
In-Reply-To: <20170712094614.76501-11-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
 <20170712094614.76501-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2494@ORSMSX104.amr.corp.intel.com>
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
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S75-V3 11/11] i40e: 25G FEC status
> improvements
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> This patch improves the system log message. The log message will be
> expanded to include the FEC mode the FW requested before link was
> established.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


