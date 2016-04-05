From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 21:52:34 +0000
Subject: [Intel-wired-lan] [next PATCH 2/2] i40e/i40evf: Add support
	for	IPIP and SIT offloads
In-Reply-To: <20160402070520.13504.3716.stgit@localhost.localdomain>
References: <20160402070114.13504.22615.stgit@localhost.localdomain>
 <20160402070520.13504.3716.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACCC8@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Saturday, April 02, 2016 12:07 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next PATCH 2/2] i40e/i40evf: Add support for IPIP
> and SIT offloads
> 
> Looking over the documentation it turns out enabling IPIP and SIT offloads
> for i40e is pretty straighforward.  As such I decided to enable them with this
> patch.  In my testing I am seeing an improvement of 8 to 10 Gb/s for IPIP and
> SIT tunnels with this offload enabled.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> 
> Testing-hints:
>   All that should be needed is to setup a pair of systems with a tunnel and
>   pass traffic over it.  Documentation on how to setup IPIP and SIT tunnels
>   can be found at:
> 
> 
> http://www.linuxfoundation.org/collaborate/workgroups/networking/tunn
> eling
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |    2 ++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     |   24 +++++++++++++++------
> --
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |   24 +++++++++++++++-----
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |    2 ++
>  4 files changed, 36 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
SIT and IPIP tunnels can be created and will pass traffic.
