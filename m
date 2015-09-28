From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Sep 2015 17:46:19 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: add GRE tunnel type to csum
	encoding
In-Reply-To: <FC41C24E35F18A40888AACA1A36F3E418AF8DF2A@fmsmsx115.amr.corp.intel.com>
References: <FC41C24E35F18A40888AACA1A36F3E418AF8DF2A@fmsmsx115.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D58@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Nelson, Shannon
> Sent: Friday, September 25, 2015 12:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: add GRE tunnel type to csum
> encoding
> 
> 
> Make sure the tx checksum encoder knows about GRE protocol and sets the
> descriptor flag appropriately.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
