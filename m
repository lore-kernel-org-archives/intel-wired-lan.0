From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Jun 2015 02:20:33 +0000
Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: synchronization of
 MAC-PHY	interface only on non- ME systems
In-Reply-To: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81A750BC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 09, 2015 3:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/5] e1000e: synchronization of MAC-PHY
> interface only on non- ME systems
> 
> On power up, the MAC - PHY interface needs to be set to PCIe, even if
> cable is disconnected.  In ME systems, the ME handles this on exit from
> Sx state. In non-ME, the driver handles it. Added a check for non-ME
> system to the driver code that handles that.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
