From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 19 Jul 2019 01:47:54 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: disable force K1-off
 feature
In-Reply-To: <20190708045546.30160-2-kai.heng.feng@canonical.com>
References: <20190708045546.30160-1-kai.heng.feng@canonical.com>
 <20190708045546.30160-2-kai.heng.feng@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970D36B7@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-07-08 at 12:55 +0800, Kai-Heng Feng wrote:
> Forwardport from http://mails.dpdk.org/archives/dev/2016-November/050658.html
> 
> MAC-PHY desync may occur causing misdetection of link up event.
> Disabling K1-off feature can work around the problem.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204057
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/hw.h      | 1 +
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 +++
>  2 files changed, 4 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
