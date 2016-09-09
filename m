From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Sep 2016 20:38:06 +0000
Subject: [Intel-wired-lan] [next PATCH S45 04/10] i40e: Remove 100
	Mbps	SGMII support for X722
In-Reply-To: <1473210312-29592-5-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCAD6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 06, 2016 6:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S45 04/10] i40e: Remove 100 Mbps
> SGMII support for X722
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch fixes the problem where driver shows 100 Mbps as a supported
> speed, and allows it to be configured for advertising on X722 devices. This
> patch fixes the problem by not setting the 100 Mbps SGMII flag for X722
> devices.
> 
> Without this patch, the user incorrectly thinks that 100 Mbps is supported
> and hence might try to advertise it on X722 devices when it is actually not a
> supported speed.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-ID: I8c3d7c4251a9402d98994ed29749b7b895a0f205
> ---
> Testing Hints: Test on Copperpeak that 100 Mbps is not listed as supported or
> advertised on ethtool. Also ensure we are not able to configure the speed to
> 100 Mbps.
> 
> HSD-number: 10021180
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver no longer reports 100Base/T nor allows advertise to be set to 100Base/T


