From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 Nov 2019 02:23:11 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Add 64 bit DMA access support
In-Reply-To: <20191113092729.42829-1-sasha.neftin@intel.com>
References: <20191113092729.42829-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717A74B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, November 13, 2019 1:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Add 64 bit DMA access support
> 
> On relevant platforms ndo_start_xmit can handle socket buffer
> fragments in high memory
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
