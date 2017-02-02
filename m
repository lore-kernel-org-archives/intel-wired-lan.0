From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Feb 2017 19:19:44 +0000
Subject: [Intel-wired-lan] [next PATCH S59 3/6] i40e: Clarify steps
	in	MAC/VLAN filters initialization routine
In-Reply-To: <1485808177-6333-4-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
 <1485808177-6333-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5DAF0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, January 30, 2017 12:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S59 3/6] i40e: Clarify steps in
> MAC/VLAN filters initialization routine
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch clarifies the reason for removal of automatically firmware-
> generated filter and explicit addition of filter which accepts frames with any
> VLAN id.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> Change-ID: Iabf180b6d61c4d8a36d3bcf8457c377a6f2aca0e
> ---
> Testing-hints:
>   Do code inspection to see if modified comment is there.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


