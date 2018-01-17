From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 Jan 2018 20:01:28 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: don't set RXDCTL.RLPML for
 82599
In-Reply-To: <20180112220256.11028.5719.stgit@localhost6.localdomain6>
References: <20180112220256.11028.5719.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A92B574@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, January 12, 2018 2:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: don't set RXDCTL.RLPML for 82599
> 
> commit 2de6aa3a666e ("ixgbe: Add support for padding packet")
> 
> Uses RXDCTL.RLPML to limit the maximum frame size on Rx when using
> build_skb. Unfortunately that register does not work on 82599.
> 
> Added an explicit check to avoid setting this register on 82599 MAC.
> 
> Extended the comment related to the setting of RXDCTL.RLPML to better
> explain its purpose.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


