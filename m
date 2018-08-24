From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Aug 2018 22:52:03 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 2/2] ixgbe: fix the return
 value for unsupported VF offload
In-Reply-To: <1534981635-27417-2-git-send-email-shannon.nelson@oracle.com>
References: <1534981635-27417-1-git-send-email-shannon.nelson@oracle.com>
 <1534981635-27417-2-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EACB1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH next-queue 2/2] ixgbe: fix the return value
> for unsupported VF offload
> 
> When failing the request because we can't support that offload, reporting
> EOPNOTSUPP makes much more sense than ENXIO.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
