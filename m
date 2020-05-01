From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 22:18:19 +0000
Subject: [Intel-wired-lan] [PATCH 06/19] igc: Align terms used in NFC
 support code
In-Reply-To: <20200424201623.10971-7-andre.guedes@intel.com>
References: <20200424201623.10971-1-andre.guedes@intel.com>
 <20200424201623.10971-7-andre.guedes@intel.com>
Message-ID: <DM6PR11MB28900CC4E0D001E9D1552C3ABCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, April 24, 2020 1:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 06/19] igc: Align terms used in NFC support
> code
> 
> The Network Flow Classification (NFC) support code from IGC driver uses
> terms such as 'rule', 'filter', 'entry', 'input' interchangeably when
> referring to NFC rules, making it harder to follow the code. This patch
> renames IGC's internal APIs, structs, and variables so we stick with the
> term 'rule' since this is the term used in ethtool APIs. It also removes
> some not applicable comments along the way. No functionality is changed
> by this patch.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  29 ++--
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 160 +++++++++----------
>  drivers/net/ethernet/intel/igc/igc_main.c    |  42 ++---
>  3 files changed, 114 insertions(+), 117 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
