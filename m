From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Jun 2015 02:24:08 +0000
Subject: [Intel-wired-lan] [PATCH 5/5] e1000e: i219 - k1 workaround for
 lpt	is not required for spt.
In-Reply-To: <429931829ff2314c8ee78454ea5310168bc03888.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
 <429931829ff2314c8ee78454ea5310168bc03888.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81A75124@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 09, 2015 3:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/5] e1000e: i219 - k1 workaround for
> lpt is not required for spt.
> 
> in spt hardware does not require this driver workaround.
> removed the conditional that caused k1 workaround execution on spt.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
