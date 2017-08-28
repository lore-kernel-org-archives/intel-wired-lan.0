From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Aug 2017 19:14:08 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add error checks when
 initializing	the PHY
In-Reply-To: <20170818224802.6099.62913.stgit@localhost6.localdomain6>
References: <20170818224802.6099.62913.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA64F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, August 18, 2017 3:48 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add error checks when initializing
> the PHY
> 
> Ignoring errors when attempting to identify the PHY can lead to a crash.
> Specifically in the case of FW controlled PHYs where the PHY read/write
> operations are set to NULL.
> 
> Removed redundant comment.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


