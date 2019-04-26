From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Apr 2019 00:00:44 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: fix cyclic resets
 at link up with active tx"
In-Reply-To: <155548879651.3454.13167784936351314661.stgit@buzz>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9703A782@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Konstantin Khlebnikov [mailto:khlebnikov at yandex-team.ru]
> Sent: Wednesday, April 17, 2019 1:13 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Sasha Levin <sashal@kernel.org>; Joseph Yasi <joe.yasi@gmail.com>;
> Brown, Aaron F <aaron.f.brown@intel.com>; Alexander Duyck
> <alexander.duyck@gmail.com>; e1000-devel at lists.sourceforge.net
> Subject: [PATCH 1/2] Revert "e1000e: fix cyclic resets at link up with active tx"
> 
> This reverts commit 0f9e980bf5ee1a97e2e401c846b2af989eb21c61.
> 
> That change cased false-positive warning about hardware hang:
> 
> e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> e1000e 0000:00:1f.6 eth0: Detected Hardware Unit Hang:
>    TDH                  <0>
>    TDT                  <1>
>    next_to_use          <1>
>    next_to_clean        <0>
> buffer_info[next_to_clean]:
>    time_stamp           <fffba7a7>
>    next_to_watch        <0>
>    jiffies              <fffbb140>
>    next_to_watch.status <0>
> MAC Status             <40080080>
> PHY Status             <7949>
> PHY 1000BASE-T Status  <0>
> PHY Extended Status    <3000>
> PCI Status             <10>
> e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> Besides warning everything works fine.
> Original issue will be fixed property in following patch.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reported-by: Joseph Yasi <joe.yasi@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203175
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
This was more of a regression check as I never did manage to replicate the tx hang, even with seemingly the same hardware.
