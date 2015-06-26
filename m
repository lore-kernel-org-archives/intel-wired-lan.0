From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Jun 2015 02:21:24 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] e1000e: i219 - increase IPG for
 speed	10/100 full duplex
In-Reply-To: <827ef89b421f872487196fb255d81e4f6d4976bc.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
 <827ef89b421f872487196fb255d81e4f6d4976bc.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81A750EA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 09, 2015 3:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/5] e1000e: i219 - increase IPG for
> speed 10/100 full duplex
> 
> In SPT/Jacksonville, there were CRC errors in speed 10/100 full duplex.
> The solution  given by the HW team is to increase the IPG from 8 to 0xC
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
