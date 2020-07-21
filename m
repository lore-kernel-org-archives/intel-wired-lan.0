From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Jul 2020 23:27:53 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix static checker warning
In-Reply-To: <20200709073416.14126-1-sasha.neftin@intel.com>
References: <20200709073416.14126-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB289062EF8CFFD28635145EA3BC780@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Thursday, July 9, 2020 12:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix static checker warning
> 
> drivers/net/ethernet/intel/igc/igc_mac.c:424 igc_check_for_copper_link()
> error: uninitialized symbol 'link'.
> This patch come to fix this warning and initialize the 'link' symbol.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 707abf069548 ("igc: Add initial LTR support")
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
