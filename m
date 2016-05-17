From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:29:12 +0000
Subject: [Intel-wired-lan] [next PATCH S37 05/15] i40evf: report RSS
 hash	capability to stack
In-Reply-To: <1463419605-30746-6-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D687D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 05/15] i40evf: report RSS hash
> capability to stack
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Set the NETIF_F_RXHASH flag to tell the stack that the device hashes
> packets.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I0394366ad8e8bf90bb2815d757a402c39628ccb2
> ---
> Testing Hints : Use ethtool -k to see that the device support receive hashing.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
ethtool -k shows device supports receive hashing
