From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2020 18:19:08 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove PCIe Control
 register
In-Reply-To: <20200401084320.26165-1-sasha.neftin@intel.com>
References: <20200401084320.26165-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890E1C08A2BBF37875C586FBCD50@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Wednesday, April 1, 2020 1:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove PCIe Control register
> 
> GCR (PCIe Control) register not in use and should be removed
> This patch clean up this register
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_regs.h | 3 ---
>  1 file changed, 3 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
