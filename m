From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 25 Sep 2015 22:17:25 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 1/3] i40e/i40evf: Fix
 handling	of napi budget
In-Reply-To: <20150924160426.22015.37868.stgit@ahduyck-vm-fedora22>
References: <20150924160027.22015.15754.stgit@ahduyck-vm-fedora22>
 <20150924160426.22015.37868.stgit@ahduyck-vm-fedora22>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1AB6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, September 24, 2015 9:04 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH v2 1/3] i40e/i40evf: Fix handling
> of napi budget
> 
> The polling routine for i40e was rounding up the budget for Rx cleanup to 1.
> This is incorrect as the netpoll poll call is expecting no Rx to be processed as
> the budget passed was 0.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    5 +++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    5 +++++
>  2 files changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
