From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:20:28 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 11/13] i40e: program
 fragmented IPv4 filter input set
In-Reply-To: <20171227132412.24115-1-alice.michael@intel.com>
References: <20171227132412.24115-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7067@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:24 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 11/13] i40e: program
> fragmented IPv4 filter input set
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When implementing support for IP_USER_FLOW filters, we correctly
> programmed a filter for both the non fragmented IPv4/Other filter, as well as
> the fragmented IPv4 filters. However, we did not properly program the input
> set for fragmented IPv4 PCTYPE. This meant that the filters would almost
> certainly not match, unless the user specified all of the flow types.
> 
> Add support to program the fragmented IPv4 filter input set. Since we always
> program these filters together, we'll assume that the two input sets must
> match, and will thus always program the input sets to the same value.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  3 +++
>  2 files changed, 13 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


