From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 May 2020 07:18:28 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Disable TSO for buffer
 overrun workaround
In-Reply-To: <20200507142108.13090-1-kai.heng.feng@canonical.com>
References: <20200507142108.13090-1-kai.heng.feng@canonical.com>
Message-ID: <DM6PR11MB2890015E69238E4215E93CB9BCB70@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org> On
> Behalf Of Kai-Heng Feng
> Sent: Thursday, May 7, 2020 7:21 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>; David S. Miller
> <davem@davemloft.net>; Neftin, Sasha <sasha.neftin@intel.com>; Dima
> Ruinskiy <dima.ruinskiy@intel.com>; Avargil, Raanan
> <raanan.avargil@intel.com>; moderated list:INTEL ETHERNET DRIVERS <intel-
> wired-lan at lists.osuosl.org>; open list:NETWORKING DRIVERS
> <netdev@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH] e1000e: Disable TSO for buffer overrun workaround
> 
> Commit b10effb92e27 ("e1000e: fix buffer overrun while the I219 is
> processing DMA transactions") imposes roughly 30% performance penalty.
> 
> The commit log states that "Disabling TSO eliminates performance loss
> for TCP traffic without a noticeable impact on CPU performance", so
> let's disable TSO by default to regain the loss.
> 
> Fixes: b10effb92e27 ("e1000e: fix buffer overrun while the I219 is processing
> DMA transactions")
> BugLink: https://bugs.launchpad.net/bugs/1802691
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

