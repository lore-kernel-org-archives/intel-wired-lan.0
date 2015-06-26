From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Jun 2015 02:23:44 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: i219 - Increase minimum
 FIFO	read/write min gap
In-Reply-To: <7c29aaeac25d60eb66d78eceb930c3da8e0f5a98.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
 <7c29aaeac25d60eb66d78eceb930c3da8e0f5a98.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81A7510E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 09, 2015 3:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: i219 - Increase minimum
> FIFO read/write min gap
> 
> Due to clocking changes in the Skylake platform, there was Jacksonville
> data corruption. To work around this, HW team reported the need
> to increase the minimum gap between the phy FIFO read and write pointers.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 46
> +++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
The fails checkpatch with an over 80 column warning, but otherwise...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
