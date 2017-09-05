From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Sep 2017 19:31:16 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: split Tx/Rx ring clearing
	for	ethtool loopback test
In-Reply-To: <20170829192148.19519.80519.stgit@localhost6.localdomain6>
References: <20170829192148.19519.80519.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9982@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, August 29, 2017 12:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: split Tx/Rx ring clearing for ethtool
> loopback test
> 
> Commit: fed21bcee7a5
> ("ixgbe: Don't bother clearing buffer memory for descriptor rings)
> 
> exposed some issues with the logic in the current implementation of
> ixgbe_clean_test_rings() that are being addressed in this patch:
> 
> - Split the clearing of the Tx and Rx rings in separate loops. Previously both Tx
> and Rx rings were cleared in a rx_desc->wb.upper.length based loop which
> could lead to issues if for w/e reason packets were received outside of the
> frames transmitted for the loopback test.
> 
> - Add check for IXGBE_TXD_STAT_DD to avoid clearing the rings if the
> transmits have not comlpeted by the time we enter ixgbe_clean_test_rings()
> 
> - Exit early on ixgbe_check_lbtest_frame() failure.
> 
> This change fixes a crash during ethtool diagnostic (ethtool -t).
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   53 ++++++++++++++---
> -----
>  1 file changed, 34 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


