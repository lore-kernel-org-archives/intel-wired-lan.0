From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 23:04:39 +0000
Subject: [Intel-wired-lan] [next PATCH S62 5/6] i40e: remove a useless
 goto	statement
In-Reply-To: <1489177325-13156-6-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
 <1489177325-13156-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104066D3@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S62 5/6] i40e: remove a useless goto
> statement
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The goto found here for when in MFP mode is pointless. It jumps to the end
> of a series of if blocks. However, right after this statement is a closing '}' for
> this if block, which will result in the program flow going to the exact same
> location as the goto statement indicates. Thus, regardless of whether we are
> in MFP mode, the program flow will resume from the same location.
> 
> This arose due to various refactoring which did not notice that this goto
> became essentially a no-op.
> 
> To properly understand this diff you will need to view a larger context than is
> given by default.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I088f73c3831aa5c4e2281380c7a3ce605594300c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


