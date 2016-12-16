From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:37:18 +0000
Subject: [Intel-wired-lan] [next PATCH S57 08/11] i40e: convert to cpu
 from	le16 to generate switch_id correctly
In-Reply-To: <1481586257-28872-9-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA499EA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, December 12, 2016 3:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S57 08/11] i40e: convert to cpu from
> le16 to generate switch_id correctly
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> On Big Endian platforms we would incorrectly calculate the wrong switch id
> since we did not properly convert the le16 value into CPU format.
> Caught by sparse.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I69a2f9fa064a0a91691f7d0e6fcc206adceb8e36
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


