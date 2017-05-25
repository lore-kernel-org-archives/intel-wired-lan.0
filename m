From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 May 2017 18:58:45 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix writes to PFQDE
In-Reply-To: <20170523210223.9463.49250.stgit@localhost6.localdomain6>
References: <20170523210223.9463.49250.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA411F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, May 23, 2017 2:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix writes to PFQDE
> 
> ixgbe_write_qde() was ignoring the qde parameter which resulted in
> PFQDE.HIDE_VLAN not being set for X550.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


