From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:17:04 +0000
Subject: [Intel-wired-lan] [next PATCH v3 11/15] i40e/i40evf: Enable
 support for SKB_GSO_UDP_TUNNEL_CSUM
In-Reply-To: <20160125051729.12004.54009.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051729.12004.54009.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C7EF@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v3 11/15] i40e/i40evf: Enable support
> for SKB_GSO_UDP_TUNNEL_CSUM
> 
> The XL722 has support for providing the outer UDP tunnel checksum on
> transmits.  Make use of this feature to support segmenting UDP tunnels with
> outer checksums enabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   19 ++++++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   19 ++++++++++++++++++-
>  2 files changed, 36 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Outer checksum present when enabled on X722
