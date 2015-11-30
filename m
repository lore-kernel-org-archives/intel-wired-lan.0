From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Nov 2015 18:56:50 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 04/12] i40e: don't add
 zero	MAC filter
In-Reply-To: <1447961665-12344-5-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-5-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F966BBE@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [V3: next PATCH S22 04/12] i40e: don't add zero
> MAC filter
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When VFs are created, the MAC address defaults to all zeros, indicating to
> the VF driver that it should use a random MAC address. However, the PF
> driver was incorrectly adding this zero MAC to the filter table, along with the
> VF's randomly generated MAC address.
> 
> Check for a good address before adding the default filter. While we're at it,
> make the error message a bit more useful.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ia100947d68140e0f73a19ba755cbffc3e79a8fcf
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, zero MAC filter not created
