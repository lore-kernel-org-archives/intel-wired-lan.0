From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Jun 2017 19:13:09 +0000
Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: Ensure MAC filter was
 added	before setting MACVLAN
In-Reply-To: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
References: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAABAC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 7, 2017 2:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: Ensure MAC filter was added
> before setting MACVLAN
> 
> This patch adds a check to ensure that adding the MAC filter was successful
> before setting the MACVLAN.  If it was unsuccessful, propagate the error.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


