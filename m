From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 16:14:42 +0000
Subject: [Intel-wired-lan] [next PATCH v3 04/15] i40e/i40evf:
 Consolidate all header changes into TSO function
In-Reply-To: <20160125051635.12004.43998.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051635.12004.43998.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C764@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:17 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 04/15] i40e/i40evf: Consolidate all
> header changes into TSO function
> 
> This patch goes through and pulls all of the spots where we were updating
> either the TCP or IP checksums in the TSO and checksum path into the TSO
> function.  The general idea here is that we should only be updating the
> header after we verify we have completed a skb_cow_head check to verify
> the head is writable.
> 
> One other advantage to doing this is that it makes things much more obvious.
> For example, in the case of IPv6 there was one spot where the offset of the
> IPv4 header checksum was being updated which is obviously incorrect.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   44 +++++++++++++++-------
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   44 +++++++++++++++------
> ----
>  2 files changed, 52 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
TSO works as expected, checksum offload works as expected, code changes properly applied
