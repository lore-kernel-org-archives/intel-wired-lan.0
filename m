From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Fri, 20 Jan 2017 22:43:27 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: move num_vfs_macvlans
 allocation into separate function
In-Reply-To: <20170120221058.7572.92313.stgit@localhost6.localdomain6>
References: <20170120221058.7572.92313.stgit@localhost6.localdomain6>
Message-ID: <87618083B2453E4A8714035B62D6799250748F2C@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Emil Tantilov
>Sent: Friday, January 20, 2017 2:11 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: move num_vfs_macvlans
>allocation into separate function
>
>Move the code allocating memory for list of MAC addresses that
>the VFs can use for MACVLAN into its own function.
>
>Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   48 +++++++++++++++-----
>----
> 1 file changed, 29 insertions(+), 19 deletions(-)

Ignore this patch - the transmission was interrupted by mistake before all
patches could go out. Use this one instead:
http://patchwork.ozlabs.org/patch/717934/

Sorry,
Emil

