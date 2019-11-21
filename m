From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 Nov 2019 02:20:22 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Prefer to use the
 pci_release_mem_regions method
In-Reply-To: <20191110140520.26531-1-sasha.neftin@intel.com>
References: <20191110140520.26531-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717A6FD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Sunday, November 10, 2019 6:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Prefer to use the
> pci_release_mem_regions method
> 
> Use the pci_release_mem_regions method istead of the
> pci_release_selected_regions method
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
