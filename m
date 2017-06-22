From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Jun 2017 18:33:59 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 7/9] i40e/i40evf:
	remove	mismatched type warnings
In-Reply-To: <20170620221701.46765-7-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
 <20170620221701.46765-7-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB947@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, June 20, 2017 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S73-V2 7/9] i40e/i40evf: remove
> mismatched type warnings
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Compiler reported several places where driver compared signed and
> unsigned types.  Cast or change the types to remove the warnings.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 6 +++---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 6 +++---
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 4 ++--
>  5 files changed, 12 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


