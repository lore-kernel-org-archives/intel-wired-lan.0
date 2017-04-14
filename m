From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Apr 2017 18:59:15 +0000
Subject: [Intel-wired-lan] [next S69 01/01] i40e: dump VF information
	in	debugfs
In-Reply-To: <20170412111652.57301-1-alice.michael@intel.com>
References: <20170412111652.57301-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B99B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 12, 2017 4:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S69 01/01] i40e: dump VF information in
> debugfs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Dump some internal state about VFs through debugfs. This provides
> information not available with 'ip link show'. To use, write "dump vf <id>" to
> the command file, or just "dump vf" to dump information on all of the VFs.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ibe32b7f4ae55d4358c0b903217475f708ada1ecd
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 51
> ++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


