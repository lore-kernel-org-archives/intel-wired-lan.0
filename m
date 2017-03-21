From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Mar 2017 22:27:16 +0000
Subject: [Intel-wired-lan] [next PATCH S62 3/6] i40e: use register for
 XL722	control register read/write
In-Reply-To: <1489177325-13156-4-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
 <1489177325-13156-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040689D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, March 10, 2017 12:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S62 3/6] i40e: use register for XL722
> control register read/write
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> The XL722 doesn't support the AQ command to read/write the control
> register so enable it to bypass the check and use the direct read/write
> method.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Change-ID: Iefecc737b57207485c90845af5989d5af518bf16
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 8 ++++++--
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


