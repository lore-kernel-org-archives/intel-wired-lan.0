From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Feb 2017 18:58:27 +0000
Subject: [Intel-wired-lan] [next PATCH S59 1/6] i40e: fix ethtool to
	get	EEPROM data from X722 interface
In-Reply-To: <1485808177-6333-2-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
 <1485808177-6333-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5DACA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S59 1/6] i40e: fix ethtool to get
> EEPROM data from X722 interface
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> Currently ethtool -e will error out with a X722 interface as its EEPROM has a
> scope limit at offset 0x5B9FFF.
> This patch fixes the issue by setting the EEPROM length to the scope limit to
> avoid NVM read failure beyond that.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> Change-ID: I0b7d4dd6c7f2a57cace438af5dffa0f44c229372
> ---
> Testing Hints: ethtool -e X722-interface.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


