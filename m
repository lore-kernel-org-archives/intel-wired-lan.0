From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 20:06:07 +0000
Subject: [Intel-wired-lan] [PATCH v2 05/13] i40e: make use of BIT()
 macro to	prevent left shift of signed values
In-Reply-To: <1460588914-20143-6-git-send-email-jacob.e.keller@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
 <1460588914-20143-6-git-send-email-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D260D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, April 13, 2016 4:08 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2 05/13] i40e: make use of BIT() macro to
> prevent left shift of signed values
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 53 +++++++++++----
> --------
>  1 file changed, 25 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver compiles without shift warnings with gcc6
