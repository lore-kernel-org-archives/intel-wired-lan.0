From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 11 May 2020 23:14:11 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: Report speed and duplex as
 unknown when device is runtime suspended
In-Reply-To: <20200505040154.24080-1-kai.heng.feng@canonical.com>
References: <20200505040154.24080-1-kai.heng.feng@canonical.com>
Message-ID: <DM6PR11MB2890802168856F147839914FBCA10@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Monday, May 4, 2020 9:02 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>; Brown, Aaron F
> <aaron.f.brown@intel.com>; David S. Miller <davem@davemloft.net>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>;
> open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open list <linux-
> kernel at vger.kernel.org>
> Subject: [PATCH v2] igb: Report speed and duplex as unknown when device is
> runtime suspended
> 
> igb device gets runtime suspended when there's no link partner. We can't
> get correct speed under that state:
> $ cat /sys/class/net/enp3s0/speed
> 1000
> 
> In addition to that, an error can also be spotted in dmesg:
> [  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost
> 
> Since device can only be runtime suspended when there's no link partner,
> we can skip reading register and let the following logic set speed and
> duplex with correct status.
> 
> The more generic approach will be wrap get_link_ksettings() with begin()
> and complete() callbacks. However, for this particular issue, begin()
> calls igb_runtime_resume() , which tries to rtnl_lock() while the lock
> is already hold by upper ethtool layer.
> 
> So let's take this approach until the igb_runtime_resume() no longer
> needs to hold rtnl_lock.
> 
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: Aaron Brown <aaron.f.brown@intel.com>
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Don't early return the routine so other info can be set.
> 
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

