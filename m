From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 25 Sep 2015 22:13:32 +0000
Subject: [Intel-wired-lan] [net PATCH 1/3] i40e: Fix handling of napi
 budget
In-Reply-To: <20150922213529.2774.42390.stgit@ahduyck-vm-fedora22>
References: <20150922213002.2774.37924.stgit@ahduyck-vm-fedora22>
 <20150922213529.2774.42390.stgit@ahduyck-vm-fedora22>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1AA4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, September 22, 2015 2:35 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH 1/3] i40e: Fix handling of napi budget
> 
> The polling routine for i40e was rounding up the budget for Rx cleanup to 1.
> This is incorrect as netpoll will call is expecting no Rx to be processed as the
> budget passed was 0.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |    5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
