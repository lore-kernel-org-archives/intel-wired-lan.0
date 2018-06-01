From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Jun 2018 17:27:48 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: check ipsec ip addr against
 mgmt filters
In-Reply-To: <1527704404-14759-1-git-send-email-shannon.nelson@oracle.com>
References: <1527704404-14759-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C5D75@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Wednesday, May 30, 2018 11:20 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: check ipsec ip addr against mgmt
> filters
> 
> Make sure we don't try to offload the decryption of an incoming packet that
> should get delivered to the management engine.  This is a corner case that
> will likely be very seldom seen, but could really confuse someone if they
> were to hit it.
> 
> Suggested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
> v2 - added the BMC IP check
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 88
> ++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


