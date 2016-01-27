From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:05:59 +0000
Subject: [Intel-wired-lan] [next PATCH v3 07/15] i40e/i40evf: Handle
 IPv6 extension headers in checksum offload
In-Reply-To: <20160125051654.12004.3596.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051654.12004.3596.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C7A7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v3 07/15] i40e/i40evf: Handle IPv6
> extension headers in checksum offload
> 
> This patch adds support for IPv6 extension headers in setting up the Tx
> checksum.  Without this patch extension headers would cause IPv6 traffic to
> fail as the transport protocol could not be identified.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   14 +++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   14 +++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
IPv6 works properly
