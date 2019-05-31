From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 May 2019 17:59:41 +0000
Subject: [Intel-wired-lan] [next PATCH S6 4/7] i40e: Add log entry while
 creating or deleting TC0
In-Reply-To: <20190528175921.30534-4-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
 <20190528175921.30534-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DD5BF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 28, 2019 10:59 AM
> To: alice.micheal at intel.com; intel-wired-lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S6 4/7] i40e: Add log entry while
> creating or deleting TC0
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Generate log entry when TC0 is created or deleted.
> Log entry is generated during main VSI setup.
> Before there was no log info about adding or deleting TC0.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


