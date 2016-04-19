From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 21:25:24 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 1/9] i40e/i40evf:
	Refactor	tunnel interpretation
In-Reply-To: <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2335@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 1/9] i40e/i40evf: Refactor
> tunnel interpretation
> 
> Refactor the interpretation of a tunnel.  This removes some code and lets us
> start using the hardware's parsing.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 13 ++++++-------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 13 ++++++-------
>  2 files changed, 12 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver builds and passes traffic
