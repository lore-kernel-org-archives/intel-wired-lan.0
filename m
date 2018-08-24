From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Aug 2018 22:51:41 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 1/2] ixgbe: disallow ipsec
 tx offload when in sr-iov mode
In-Reply-To: <1534981635-27417-1-git-send-email-shannon.nelson@oracle.com>
References: <1534981635-27417-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EACA1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Wednesday, August 22, 2018 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next-queue 1/2] ixgbe: disallow ipsec tx
> offload when in sr-iov mode
> 
> There seems to be a problem in the x540's internal switch wherein if SR/IOV
> mode is enabled and an offloaded IPsec packet is sent to a local VF, the
> packet is silently dropped.  This might never be a problem as it is somewhat a
> corner case, but if someone happens to be using IPsec offload from the PF to
> a VF that just happens to get migrated to the local box, communication will
> mysteriously fail.
> 
> Not good.
> 
> A simple way to protect from this is to simply not allow any IPsec offloads for
> outgoing packets when num_vfs != 0.  This doesn't help any offloads that
> were created before SR/IOV was enabled, but we'll get to that later.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


