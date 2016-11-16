From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Nov 2016 20:34:19 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 07/15] i40e/i40evf:
 replace	for memcpy with single memcpy call in ethtool
In-Reply-To: <1478639119-14656-8-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA36D7F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S52-V2 07/15] i40e/i40evf: replace for
> memcpy with single memcpy call in ethtool
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> memcpy replaced with single memcpy call in ethtool.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I3f5bef6bcc593412c56592c6459784db41575a0a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


