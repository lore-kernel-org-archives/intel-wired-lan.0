From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:33:39 +0000
Subject: [Intel-wired-lan] [next S66 v2 01/11] i40e: update error
 message	when trying to add invalid filters
In-Reply-To: <20170405115103.67374-1-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B11B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 01/11] i40e: update error message
> when trying to add invalid filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Re-word the error message displayed when adding a filter with an invalid
> flow type. Additionally, report a distinct error message when the IPv4
> protocol is at fault.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Iba3d85b87f8d383c97c8bdd180df34a6adf3ee67
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


