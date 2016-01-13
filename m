From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 18:21:15 +0000
Subject: [Intel-wired-lan] [next PATCH S25 09/16] i40e: add 20G speed
 for tx	bandwidth calculations
In-Reply-To: <1450901156-30904-10-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-10-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98013D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 09/16] i40e: add 20G speed for tx
> bandwidth calculations
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When calculating TX bandwidth for VFs, we need to know the link speed to
> make sure we don't allocate more bandwidth than is available. Add 20G link
> speed to the switch statement so we can support devices that link at that
> speed.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I5409f6139d549e5832777db9c22ca0664e0c5f8b
> ---
> Testing-Hints:
> Find a device that links at 20G and make sure you can set VF tx bandwidth on
> that device.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, able to correctly set Tx bandwidth on 20G device.
