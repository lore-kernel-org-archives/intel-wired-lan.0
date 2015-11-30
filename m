From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Nov 2015 18:59:18 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 08/12] i40e: hush
	little	warnings
In-Reply-To: <1447961665-12344-9-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-9-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F966BDA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [V3: next PATCH S22 08/12] i40e: hush little
> warnings
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> These messages seem big and scary, but they're really not. The driver can
> fully recover from any of these. The overflow error in particular can happen
> when enabling a bunch of VFs and the VF driver is not blacklisted.
> 
> Since these messages are really for debugging purposes, reclassify them as
> such.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I628d0f5e135e7063450ba05393a50b7af23aa6d7
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
