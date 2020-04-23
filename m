From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 19:33:44 +0000
Subject: [Intel-wired-lan] [PATCH 5/5] igc: Dump ETQF registers
In-Reply-To: <20200407210711.24371-6-andre.guedes@intel.com>
References: <20200407210711.24371-1-andre.guedes@intel.com>
 <20200407210711.24371-6-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890329D366B316B6325B15EBCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, April 7, 2020 2:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/5] igc: Dump ETQF registers
> 
> This patch adds the EType Queue Filter (ETQF) registers to the list of
> registers dumped by igc_get_regs().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
