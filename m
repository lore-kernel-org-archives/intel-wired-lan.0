From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 26 Apr 2019 00:05:02 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: start network tx queue
 only when link is up
In-Reply-To: <155548880068.3454.1621821881762819373.stgit@buzz>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
 <155548880068.3454.1621821881762819373.stgit@buzz>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9703A79B@ORSMSX103.amr.corp.intel.com>
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
> Subject: [PATCH 2/2] e1000e: start network tx queue only when link is up
> 
> Driver does not want to keep packets in tx queue when link is lost.
> But present code only reset NIC to flush them, but does not prevent
> queuing new packets. Moreover reset sequence itself could generate
> new packets via netconsole and NIC falls into endless reset loop.
> 
> This patch wakes tx queue only when NIC is ready to send packets.
> 
> This is proper fix for problem addressed by commit 0f9e980bf5ee
> ("e1000e: fix cyclic resets at link up with active tx").
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Again, more of a regression check than a test that the patch solves the problem as I did not manage to trigger the hang.
