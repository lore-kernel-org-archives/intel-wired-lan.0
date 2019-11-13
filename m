From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 13 Nov 2019 22:54:09 +0000
Subject: [Intel-wired-lan] [PATCH v2] igc: Add scatter gather support
In-Reply-To: <20191031060607.23975-1-sasha.neftin@intel.com>
References: <20191031060607.23975-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971748BE@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, October 30, 2019 11:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] igc: Add scatter gather support
> 
> Scatter gather is used to do DMA data transfers of data that is written to
> noncontiguous areas of memory.
> This patch enables scatter gather support.
> 
> v2: fix typo in commit message
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
