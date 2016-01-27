From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:26:06 +0000
Subject: [Intel-wired-lan] [next PATCH v3 13/15] i40e: Do not drop
 support for IPv6 VXLAN or GENEVE tunnels
In-Reply-To: <20160125051743.12004.44984.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051743.12004.44984.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C80E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:18 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 13/15] i40e: Do not drop support
> for IPv6 VXLAN or GENEVE tunnels
> 
> All of the documentation in the datasheets for the XL710 do not call out any
> reason to exclude support for IPv6 based tunnels.  As such I am dropping the
> code that was excluding these tunnel types from having their port numbers
> recognized.  This way we can take advantage of things such as checksum
> offload for inner headers over IPv6 based VXLAN or GENEVE tunnels.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   12 ------------
>  1 file changed, 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied
