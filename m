From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 16:00:01 +0000
Subject: [Intel-wired-lan] [next PATCH v3 01/15] i40e/i40evf: Drop outer
 checksum offload that was not requested
In-Reply-To: <20160125051612.12004.32828.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051612.12004.32828.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C731@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:16 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 01/15] i40e/i40evf: Drop outer
> checksum offload that was not requested
> 
> The i40e and i40evf drivers contained code for inserting an outer checksum
> on UDP tunnels.  The issue however is that the upper levels of the stack
> never requested such an offload and it results in possible errors.
> 
> In addition the same logic was being applied to the Rx side where it was
> attempting to validate the outer checksum, but the logic there was incorrect
> in that it was testing for the resultant sum to be equal to the header
> checksum instead of being equal to 0.
> 
> Since this code is so massively flawed, and doing things that we didn't ask for
> it to do I am just dropping it, and will bring it back later to use as an offload for
> SKB_GSO_UDP_TUNNEL_CSUM which can make use of such a feature.
> 
> As far as the Rx feature I am dropping it completely since it would need to be
> massively expanded and applied to IPv4 and IPv6 checksums for all parts, not
> just the one that supports Tx checksum offload for the outer.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |    2 -
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   47 +++----------------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |    1 -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   46 +++---------------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |    1 -
>  5 files changed, 10 insertions(+), 87 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Outer checksum not present on UDP tunnel traffic.
