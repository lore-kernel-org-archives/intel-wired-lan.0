From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:25:27 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: move num_vfs_macvlans
 allocation into separate function
In-Reply-To: <20170120221145.7616.93906.stgit@localhost6.localdomain6>
References: <20170120221145.7616.93906.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D632@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, January 20, 2017 2:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: move num_vfs_macvlans
> allocation into separate function
> 
> Move the code allocating memory for list of MAC addresses that the VFs can
> use for MACVLAN into its own function.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   48 +++++++++++++++----
> -----
>  1 file changed, 29 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
