From: Bynoe, Ronald J <ronald.j.bynoe@intel.com>
Date: Tue, 3 Jan 2017 15:49:02 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Avoid Tx hang by not allowing
 more than the number of VFs supported.
In-Reply-To: <20161223180814.6949.16530.stgit@ukketine.jf.intel.com>
References: <20161223180814.6949.16530.stgit@ukketine.jf.intel.com>
Message-ID: <1483458539.2894.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-12-23 at 10:08 -0800, Usha Ketineni wrote:
> When DCB is enabled, add checks to ensure creation of number of VF's is
> valid based on the traffic classes configured by the device.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   26 +++++++++++++++++++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |    3 +++
>  2 files changed, 26 insertions(+), 3 deletions(-)

Tested-by: Ronald Bynoe <ronald.j.bynoe@intel.com>
