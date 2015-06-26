From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Jun 2015 02:21:03 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] e1000e: i219 - fix to enable both
 ulp	and EEE in Sx state
In-Reply-To: <78dc0c19f5ddc7fc59e6f54e1950ed1aa7d7ddcc.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
 <78dc0c19f5ddc7fc59e6f54e1950ed1aa7d7ddcc.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81A750D3@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 09, 2015 3:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/5] e1000e: i219 - fix to enable both
> ulp and EEE in Sx state
> 
> In Jacksonville, there is a hardware bug that prevented ULP entry.
> A side effect of the original software fix for this was that EEE in
> Sx couldn't be enabled.
> This patch implements a modified flow that allows both ULP and EEE in Sx.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 46 +++++++++++++++++++++---
> -----
>  1 file changed, 33 insertions(+), 13 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
