From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Mar 2017 23:31:07 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf: dereference vsi after vsi
	has	been null checked
In-Reply-To: <20170320120303.32284-1-colin.king@canonical.com>
References: <20170320120303.32284-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104068C1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Colin King
> Sent: Monday, March 20, 2017 5:03 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40evf: dereference vsi after vsi has been
> null checked
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> vsi is being dereferenced before the vsi null check; if vsi is null we end up
> with a null pointer dereference.  Fix this by performing vsi deference after
> the vsi null check.  Also remove the need for using adapter by using vsi-
> >back->cinst.
> 
> Detected by CoverityScan, CID#1419696, CID#1419697 ("Dereference before
> null check")
> 
> Fixes: ed0e894de7c133 ("i40evf: add client interface")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_client.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



