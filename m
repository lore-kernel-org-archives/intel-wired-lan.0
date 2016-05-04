From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 16:41:27 +0000
Subject: [Intel-wired-lan] [next PATCH S36 09/12] i40e: set context to
 use	VSI RSS Lut for SR-IOV
In-Reply-To: <1462313600-3123-10-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D59DA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 09/12] i40e: set context to use VSI
> RSS Lut for SR-IOV
> 
> From: "Ashish Shah" <ashish.n.shah@intel.com>
> 
> For the SR-IOV VSIs, when the queue filtering section is valid, the RSS LUT
> needs to be set to use the VSI specific lookup table (otherwise it will use the
> PF RSS LUT table).
> 
> Signed-off-by: Ashish Shah <ashish.n.shah@intel.com>
> Change-ID: Ia9377cc818078238a75c3bdeade1b593a91b3480
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
RSS works as expected on PF and VF with correct look up table for each
