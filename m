From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Sep 2016 17:15:53 +0000
Subject: [Intel-wired-lan] [next PATCH S47 3/9] i40e: Bit test
	mask	correction
In-Reply-To: <1473895479-23035-4-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
 <1473895479-23035-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E4D2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, September 14, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S47 3/9] i40e: Bit test mask correction
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> Incorrect bit mask was used for testing "get link status" response.
> Instead of I40E_AQ_LSE_ENABLE (which is actually 0x03) it most probably
> should be I40E_AQ_LSE_IS_ENABLED (which is defined as 0x01).
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> Change-ID: Ia199142906720507f847de3a33a25c61a9781b2f
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

