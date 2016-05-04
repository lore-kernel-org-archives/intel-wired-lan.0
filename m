From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 16:33:03 +0000
Subject: [Intel-wired-lan] [next PATCH S36 08/12] i40e: Correct UDP
 packet	header for non_tunnel-ipv6
In-Reply-To: <1462313600-3123-9-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D59C8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 08/12] i40e: Correct UDP packet
> header for non_tunnel-ipv6
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch corrects Rx ptype payload layer for non_tunneled ipv6. It should
> be layer 4 for UDP, instead of layer 3.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Change-ID: I9382e4458ab3c4e58f6d2e9f195d5d4ee513805e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

