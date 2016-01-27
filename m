From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:08:58 +0000
Subject: [Intel-wired-lan] [next PATCH v3 09/15] i40e/i40evf: Add
 exception handling for Tx checksum
In-Reply-To: <20160125051710.12004.58962.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051710.12004.58962.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C7C7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v3 09/15] i40e/i40evf: Add exception
> handling for Tx checksum
> 
> Add exception handling to the Tx checksum path so that we can handle cases
> of TSO where the frame is bad, or Tx checksum where we didn't recognize a
> protocol
> 
> Drop I40E_TX_FLAGS_CSUM as it is unused, move the CHECKSUM_PARTIAL
> check into the function itself so that we can decrease indent.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   34 ++++++++++++++++------
> --
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |    1 -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   35 ++++++++++++++++----
> -----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |    1 -
>  4 files changed, 45 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Tx checksum/offloading/TSO works correctly
